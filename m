From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sat, 25 Mar 2017 11:55:47 +0900
Subject: [PATCH] selinux: fix double free in selinux_parse_opts_str()
In-Reply-To: <CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
References: <1490355659-13787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
Message-ID: <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Paul Moore wrote:
> Hi,
> 
> Thank you very much for this patch, but I think we need to look a bit
> harder at this problem as it appears that many callers assume that
> selinux_parse_opts_str() cleans up after itself.  Looking quickly I
> found what appear to be two problems, there are likely more ...
> 
> * selinux_sb_remount()
> If selinux_parse_opts_str() fails here it doesn't appear we cleanup
> opts properly, although changing the jump target from
> "out_free_secdata" to "out_free_opts" would appear to correct this.
> 
> * btrfs_mount()
> This function calls parse_security_options() which in turn calls
> security_sb_parse_opts_str(), but if parse_security_options() fails in
> this case the security_mnt_opts are not free'd.
> 
> At this point I wonder if the quick fix is to set opts->mnt_opts to
> NULL after kfree()'ing it, or simply drop the kfree() call and call
> security_free_mnt_opts() in the out_err error handling code; the
> latter is a bit more work than needed, but I believe it should be safe
> in all conditions.

I think the latter is better.
We might allow multiple LSM modules to parse mount options in future
(not limited to SELinux + Smack combination, small LSMs might want to
parse mount options). Then, calling a common function for releasing
memory allocated by individual module will become needed.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
