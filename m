From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 26 Apr 2018 21:07:20 +0900
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <CAMp4zn9ojWn5oNMgZ6OKQR4=JhSnsrCzO443a8A71xfo_eLzHA@mail.gmail.com>
References: <cover.1524645853.git.sargun@sargun.me>
	<201804260715.w3Q7FOlb036047@www262.sakura.ne.jp>
	<CAMp4zn9ojWn5oNMgZ6OKQR4=JhSnsrCzO443a8A71xfo_eLzHA@mail.gmail.com>
Message-ID: <201804262107.HGG56259.OFOtHSOFQLVFJM@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> On Thu, Apr 26, 2018 at 12:15 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Suggested changes on top of your series.
> >
> > But I think that your series still lacks critical code which is also not yet
> > implemented in Casey's work. The reason call_int_hook() can work for hooks
> > which change state (e.g. security_inode_alloc()) is that there is no need to
> > call undo function because a hook which might change state (so-called Major LSM
> > modules) is always the last entry of the list. If we allow runtime registration
> > of LSM modules, there is a possibility that call_int_hook() returns an error
> > after some LSM module allocated memory. You need to implement safe transaction
> > in order to allow FOR_EACH_SECURITY_HOOK_RW hooks to return an error.
> >
> My suggestion is we create a whitelist of "minor" hooks". These hooks
> should have no state, or blob manipulation. The only downside here, is
> sometimes you can cheat, and do what Yama does, in the sense of
> keeping its own relationships completely outside of the blobs which
> live on the actually tasks structs themselves. Given that Yama has
> done this successfully, I think we should trust module authors to not
> make these mistakes.

I didn't understand what you mean. Basically, what this series is doing is

int security_inode_alloc(struct inode *inode)
{
	struct security_hook_list *P;
	inode->i_security = NULL;
	hlist_for_each_entry(P, &security_hook_heads_ro.inode_alloc_security, list) {
		int RC = P->hook.inode_alloc_security(inode);
		if (RC != 0)
			return RC; // <= So far only one major module can stay on the list.
	}
	/*** Start of changes made by this series ***/
	hlist_for_each_entry(P, &security_hook_heads_rw.inode_alloc_security, list) {
		int RC = P->hook.inode_alloc_security(inode);
		if (RC != 0)
			return RC; // <= Not calling inode_free_security() for corresponding successful inode_alloc_security().
	}
	/*** End of changes made by this series ***/
	return 0;
}

and what Casey's series is doing is

int security_inode_alloc(struct inode *inode)
{
	struct security_hook_list *P;
	inode->i_security = NULL;
	hlist_for_each_entry(P, &security_hook_heads.inode_alloc_security, list) {
		int RC = P->hook.inode_alloc_security(inode);
		if (RC != 0) {
			/*** Start of changes made by Casey's series ***/
			hlist_for_each_entry(P, &security_hook_heads.inode_free_security, list) {
				P->hook.inode_free_security(inode); // <= Might call inode_free_security() without corresponding successful inode_alloc_security().
			}
			/*** End of changes made by Casey's series ***/
			return RC;
		}
	}
	return 0;
}

. We need to keep track of which module's inode_free_security() needs to be called

int security_inode_alloc(struct inode *inode)
{
	struct security_hook_list *P1;
	struct security_hook_list *P2;
	inode->i_security = NULL;
	hlist_for_each_entry(P1, &security_hook_heads_ro.inode_alloc_security, list) {
		int RC = P1->hook.inode_alloc_security(inode);
		if (RC != 0)
			goto out;
	}
	hlist_for_each_entry(P1, &security_hook_heads_rw.inode_alloc_security, list) {
		int RC = P1->hook.inode_alloc_security(inode);
		if (RC != 0)
			goto out;
	}
	return 0;
out:
	hlist_for_each_entry(P2, &security_hook_heads_ro.inode_free_security, list) {
		if (P1 == P2)
			goto done;
		P2->hook.inode_free_security(inode);
	}
	hlist_for_each_entry(P2, &security_hook_heads_rw.inode_free_security, list) {
		if (P1 == P2)
			goto done;
		P2->hook.inode_free_security(inode);
	}
done:
	return ret;
}

while handling race condition that foo->inode_alloc_security(inode) returned an error and
foo is removed from the list and is waiting for SRCU grace period before hitting P1 == P2
check and therefore by error calls all LSM modules' ->inode_free_security(inode) hooks.



> > @@ -138,39 +134,17 @@ void security_delete_hooks(struct lsm_info *info)
> >  }
> >  EXPORT_SYMBOL_GPL(security_delete_hooks);
> >
> > -static void lock_existing_hooks(void)
> > -{
> > -       struct lsm_info *info;
> > -
> > -       /*
> > -        * Prevent module unloading while we're doing this
> > -        * try_module_get may fail (safely), if the module
> > -        * is already unloading -- allow that.
> > -        */
> > -       mutex_lock(&module_mutex);
> > -       mutex_lock(&lsm_info_lock);
> > -       pr_info("Locking security hooks\n");
> > -
> > -       hlist_for_each_entry(info, &lsm_info_head, list)
> > -               WARN_ON(!try_module_get(info->owner));
> > -
> > -       mutex_unlock(&lsm_info_lock);
> > -       mutex_unlock(&module_mutex);
> > -}
> Why do you think we should remove this code? I think that it's
> valuable to keep in there because it prevents an administrator from
> accidentally panicing the system. For example, if you have admin A
> lock the security hooks, and then admin B comes along and tries to
> unload the module, IMHO they shouldn't get a panic, and by default
> (unless they rmmod -f) they should just a nice warning that suggests
> they're doing something wrong (like the module is in use).

What I suggested is

 	/* Doing init or already dying? */
 	if (mod->state != MODULE_STATE_LIVE) {
 		/* FIXME: if (force), slam module count damn the torpedoes */
 		pr_debug("%s already dying\n", mod->name);
 		ret = -EBUSY;
 		goto out;
 	}
 
+	ret = security_remove_module(mod);
+	if (ret)
+		goto out;
 	/* If it has an init func, it must have an exit func to unload */
 	if (mod->init && !mod->exit) {
 		forced = try_force_unload(flags);

and check like

int security_remove_module(struct module *mod)
{
	struct lsm_info *info;
	int ret = 0;

	if (security_allow_unregister_hooks)
		return 0;

	mutex_lock(&lsm_info_lock);
	hlist_for_each_entry(info, &lsm_info_head, list)
		if (mod == info->owner)
			ret = -EPERM;
	mutex_unlock(&lsm_info_lock);
	return ret;
}

rather than using register_module_notifier().



> Thanks for the feedback. I think we're getting there at last.
> 
> I'd like Casey and James' feedback as well. I think the big questions are:
> 1) Can we assume that LSM authors will not shoot themselves in the
> foot and break major LSMs?

What "break major LSMs" means? Regardless of whether LKM-based LSMs use
inode->i_security, we need to handle race condition described above.

> 2) Should we protect the administrator from themselves (try_module_get)?

What I suggested is "not to play with module usage count".

> 3) Is it okay to allow hooks to be unloaded at all?
> 
> I think no matter what the answers to 1-3 are, we can apply patch 1,
> 2, and 3 once I include the fix-ups that you suggested here.
> 
> Patch 4 is heavily dependent on the answer to (1), and patches 6 is
> heavily dependent on the answer to (3).
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
