From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 3 Mar 2018 17:22:05 +0900
Subject: [RFC v2 1/2] WhiteEgret: Add WhiteEgret core functions.
In-Reply-To: <TYXPR01MB18540A7EDCE6F5BE8CFE130EF1C50@TYXPR01MB1854.jpnprd01.prod.outlook.com>
References: <20180301073830.2551-1-masanobu2.koike@toshiba.co.jp>
	<458a466a-78bc-80d4-4d52-64b92d39f416@schaufler-ca.com>
	<TYXPR01MB18540A7EDCE6F5BE8CFE130EF1C50@TYXPR01MB1854.jpnprd01.prod.outlook.com>
Message-ID: <201803031722.EDF21804.QHMOtFJOFFOLSV@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Masanobu Koike wrote:
> On Friday, March 02, 2018 12:43 AM, Casey Schaufler wrote:
> > On 2/28/2018 11:38 PM, Masanobu Koike wrote:
> > > @@ -264,6 +266,9 @@ choice
> > >  	config DEFAULT_SECURITY_APPARMOR
> > >  		bool "AppArmor" if SECURITY_APPARMOR=y
> > >
> > > +	config DEFAULT_SECURITY_WHITEEGRET
> > > +		bool "WhiteEgret" if SECURITY_WHITEEGRET=y
> > > +
> > 
> > I don't see this module using any security blobs. Is there
> > a reason you're not making this a minor (like yama) module
> > instead of a major (like AppArmor) module?
> 
> Thank you for your suggestion.
> We are now developing WhiteEgret on the environment
> it works certainly.
> 

??? What Casey suggested is effectively

----------
--- a/security/whiteegret/init.c
+++ b/security/whiteegret/init.c
@@ -48,9 +48,6 @@ static int __init we_init(void)
 {
 	int rc;
 
-	if (!security_module_enable("whiteegret"))
-		return 0;
-
 	security_add_hooks(we_hooks, ARRAY_SIZE(we_hooks), "whiteegret");
 
 	rc = we_specific_init();
----------

, isn't it? Unlike Yama, adding whiteegret_add_hooks() to security_init()
is not useful, for security_init() is called too early to create securityfs
entries for WhiteEgret.

Current version uses security= parameter as a switch for enabling/disabling
WhiteEgret, doesn't it? If WhiteEgret does not use security= as a switch,
is some other switch (e.g. __setup()) expected?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
