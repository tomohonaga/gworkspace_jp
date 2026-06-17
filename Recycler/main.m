/* main.m
 *  
 * Copyright (C) 2004-20104Free Software Foundation, Inc.
 *
 * Author: Enrico Sersale <enrico@imago.ro>
 * Date: June 2004
 *
 * This file is part of the GNUstep Recycler application
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 31 Milk Street #960789 Boston, MA 02196 USA.
 */

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <GNUstepBase/GNUstep.h>

#import "Recycler.h"


void createMenu();

int main(int argc, char **argv, char **env)
{
  CREATE_AUTORELEASE_POOL (pool);
  Recycler *recycler = [Recycler recycler];
  NSApplication *app = [NSApplication sharedApplication];

  createMenu();

  [app setDelegate: recycler];    
  [app run];
  RELEASE (pool);
  
  return 0;
}

//id<NSMenuItem> addMenuItem(NSMenu *menu, NSString *str, 
//                        NSString *comm, NSString *sel, NSString *key)
id<NSMenuItem> addMenuItem(NSMenu *menu, NSString *str, 
                        NSString *sel, NSString *key)
{
  //id<NSMenuItem>item = [menu addItemWithTitle: NSLocalizedString(str, comm)
  //                                     action: NSSelectorFromString(sel) keyEquivalent: key]; 
  id<NSMenuItem>item = [menu addItemWithTitle: str
                                       action: NSSelectorFromString(sel) keyEquivalent: key]; 
  return item;
}

void createMenu()
{
  NSMenu *mainMenu;
  NSMenu *info, *file, *edit;
  id<NSMenuItem> menuItem;

	// Main
  mainMenu = AUTORELEASE ([[NSMenu alloc] initWithTitle: _(@"Recycler")]);
    	
	// Info 	
	menuItem = addMenuItem(mainMenu, NSLocalizedString(@"Info", @""), nil, @"");
	info = AUTORELEASE ([NSMenu new]);
	[mainMenu setSubmenu: info forItem: menuItem];	
	addMenuItem(info, NSLocalizedString(@"Info Panel...", @""), @"showInfo:", @"");
	addMenuItem(info, NSLocalizedString(@"Preferences...", @""), @"showPreferences:", @"");
	addMenuItem(info, NSLocalizedString(@"Help...", @""), nil, @"?");

	// File
	menuItem = addMenuItem(mainMenu, NSLocalizedString(@"File", @""), nil, @"");
	file = AUTORELEASE ([NSMenu new]);
	[mainMenu setSubmenu: file forItem: menuItem];		
	addMenuItem(file, NSLocalizedString(@"Empty Recycler", @""), @"emptyTrashFromMenu:", @"");

	// Edit
	menuItem = addMenuItem(mainMenu, NSLocalizedString(@"Edit", @""), nil, @"");
	edit = AUTORELEASE ([NSMenu new]);
	[mainMenu setSubmenu: edit forItem: menuItem];	
	addMenuItem(edit, NSLocalizedString(@"Paste", @""), @"paste:", @"v");
	 
	// Hide
	addMenuItem(mainMenu, NSLocalizedString(@"Hide", @""), @"hide:", @"h");
	
	// Quit
	addMenuItem(mainMenu, NSLocalizedString(@"Quit", @""), @"terminate:", @"");

	[mainMenu update];

	[[NSApplication sharedApplication] setMainMenu: mainMenu];		
}
