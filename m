From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 16 Mar 2017 20:09:49 +0900
Subject: [PATCH] LSM: Revive security_task_alloc() hook and per "struct
	task_struct" security blob.
In-Reply-To: <20170313153716.GA29279@mail.hallyn.com>
References: <1489293309-41929-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<20170313153716.GA29279@mail.hallyn.com>
Message-ID: <201703162009.BDJ06594.FHOOLJOVtFMSQF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Serge E. Hallyn wrote:
> > @@ -533,8 +533,13 @@
> >   *	manual page for definitions of the @clone_flags.
> >   *	@clone_flags contains the flags indicating what should be shared.
> >   *	Return 0 if permission is granted.
> > + * @task_alloc:
> > + *      @task task being allocated.
> 
> Note that here you have spaces not tabs
> 

Oh, thanks.

I think this patch got enough Acked-by:s.

  Serge Hallyn <serge@hallyn.com>
  Casey Schaufler <casey@schaufler-ca.com>

James, should I repost with spaces fixed?

Also, I appreciate if you can update #next to 4.11-rc2 because
4.11-rc1 is not suitable for testing due to memory corruption bug.
http://lkml.kernel.org/r/201703090625.v296PNFI070895 at www262.sakura.ne.jp
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
