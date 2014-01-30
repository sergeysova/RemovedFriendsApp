package com.app {
	import com.vk.*;
	import com.app.*;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	
	public class Application {
		private var VK:APIConnection;
		private var UF:FriendsList;
		private var API:AppAPI;
		private var FV:Object;
		private var g:MovieClip;
		
		public function Application( flashVars:Object, frl:MovieClip, global:MovieClip ) {
			FV = flashVars as Object;
			VK = new APIConnection(flashVars);
			UF = new FriendsList(frl);
			API = new AppAPI();
			g = global;
			
			if ( flashVars['viewer_id'] ) {
				g.viewer_id.text = flashVars['viewer_id'];
			}
			
			//Security.allowDomain("*");
			g.helpf.visible = false;
			g.viewer_id.visible = false;
			
			g.save.addEventListener(MouseEvent.MOUSE_DOWN, buttonSaveClick);
			g.update.addEventListener(MouseEvent.MOUSE_DOWN, buttonUpdateClick);
		}
		
		public function loadFList():void {
			UF.Clear();
			VK.api("friends.get", {order:"name", v:"5.7"}, function(response){
			var friendlist:String = response.items.join(",");
			API.call("settings.update",
				{
					received: friendlist,
					uid: FV['viewer_id'],
					auth_key: FV['auth_key']
				},
				function(response){
					if ( response.firstRun ) {
						UF.Add("Приложение запущено первый раз");
						UF.Add("Перезагрузите страницу");
						g.helpf.visible = false;
						return;
					}
					if ( response.deleted ) {
						if ( response.deleted.length < 1 ) {
							UF.Clear();
							UF.Add("[ Все Ваши друзья с Вами ]");
							g.helpf.visible = false;
							return;
						}
						
						var users:String = response.deleted.join(",");
						UF.Add("Загрузка...", false);
						VK.api("users.get",
							{user_ids: users, fields: "photo_50", v: "3.0"},
							function(response) {
								UF.Clear();
								var r:Array = response as Array;
								for ( var i:Number = 0; i < r.length; i++) {
									if ( i > 10 ) {
										break;
									}
									var u:Object = r[i];
									UF.Add(String(u.first_name + " " + u.last_name), u.photo_50 + "?h=" + new Date().getTime() );
								}
								g.helpf.visible = true;
							},
							function(error){
								UF.Clear();
								UF.Add("Ошибка 0x001! Перезагрузите приложение!");
								g.helpf.visible = false;
							}
						);
					} else {
						UF.Add("[ Все Ваши друзья с Вами ]");
						g.helpf.visible = false;
					}
				},
				function(error){
					UF.Clear();
					UF.Add("Ошибка 0x002! Перезагрузите приложение!");
					UF.Add("Error #" + error.error + ": " + error.error_msg);
					g.helpf.visible = false;
				});
		}, function(error){
			UF.Clear();
			UF.Add("Ошибка 0x003! Перезагрузите приложение!");
			g.helpf.visible = false;
		});
		}
		
		private function buttonSaveClick(e:Event):void {
			trace(1);
			
			VK.api("friends.get",
				{v:"5.7"},
				function(response){
					var list:String = response.items.join(",");
					API.call("settings.update.save",
						{received: list as String},
						function(resp) {
							if ( resp.error ) {
								UF.Clear();
								UF.Add("Ошибка сохранения! Попробуйте позже!");
								g.helpf.visible = false;
								return;
							}
							
							UF.Clear();
							UF.Add("Успешно сохранено!");
							g.helpf.visible = false;
						},
						function(err) {
							
						}
					);
				},
				function (error) {
					UF.Clear();
					UF.Add("Ошибка сохранения! Попробуйте позже!");
					g.helpf.visible = false;
					return;
				}
			);
			
			
			return; // ---------------------------------------------------------------------
			VK.api("friends.get", {order:"name", v:"5.0"}, function(response) {
				   trace(2);
				var friendlist:String = response.items.join(",");
				API.call("settings/update/save",
					{received: friendlist},
					function(r) {
						if ( r.error ) {
							UF.Clear();
							UF.Add("Ошибка сохранения! Попробуйте позже!");
							g.helpf.visible = false;
							return;
						}
						
						UF.Clear();
						UF.Add("Успешно сохранено!");
						g.helpf.visible = false;
					},
					function(error) {
						UF.Clear();
						UF.Add("Ошибка 0x004! Перезагрузите приложение!");
						g.helpf.visible = false;
					}
				); // API.call
			}); // VK.api
		}; // buttonSaveClick
		
		private function buttonUpdateClick(e:Event):void {
			UF.Clear();
			g.helpf.visible = false;
			UF.Add("Загрузка...");
			loadFList();
		}

	}
	
}