From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 23 Mar 2017 06:55:34 +0900
Subject: [PATCH 2/2] LSM: Make security_hook_heads a local variable.
In-Reply-To: <CAGXu5jJ7-ZkiiwXQLYPgCPnwaK74hOm=2Fh1G4ONkxzJXPPn0Q@mail.gmail.com>
References: <1490179580-7065-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAGXu5jJ7-ZkiiwXQLYPgCPnwaK74hOm=2Fh1G4ONkxzJXPPn0Q@mail.gmail.com>
Message-ID: <201703230655.JIB51508.FHOFtVOOLMSQFJ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Kees Cook wrote:
> On Wed, Mar 22, 2017 at 3:46 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > We might introduce different "struct security_hook_heads" for built-in
> > LSM modules and dynamically loadable LSM modules when we start allowing
> > dynamically loadable LSM modules. But even if we decide to use different
> > lists, there is no need to export "struct security_hook_heads" for
> > dynamically loadable LSM modules and define different LSM_HOOK_INIT() for
> > built-in LSM modules and dynamically loadable LSM modules only for
> > switching list_head's address. Let's use index number within
> > "struct security_hook_heads" so that we can switch list_head's address
> > inside the registration function.
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Cc: James Morris <james.l.morris@oracle.com>
> 
> While somewhat in line with my suggestion about enum, this loses us
> compile-time bounds checking on the offset (i.e. idx here could be
> outside the list_heads). I'd want this bounds checked first.

Isn't suspecting .idx equivalent to suspecting .head which is currently not suspected? ;-)

But no problem. It is not a costly thing.

-		list_add_tail_rcu(&hooks[i].list, &list[hooks[i].idx]);
+		unsigned int idx = hooks[i].idx;
+		if (idx < sizeof(struct security_hook_heads) / sizeof(struct list_head))
+			list_add_tail_rcu(&hooks[i].list, &list[idx]);

> 
> However, I'm not starting to remember that perhaps the reason an enum
> wasn't used was to gain type checking on the hook function
> assignments? My memory is fuzzy...

Right.

> 
> -Kees
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
