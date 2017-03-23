From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 23 Mar 2017 19:49:12 +0900
Subject: security: double-free in superblock_doinit
In-Reply-To: <CACT4Y+bb83Vku6iTtSp34HzM+hr+ZZD4Pex-N10qehfXXhHQjA@mail.gmail.com>
References: <CACT4Y+bb83Vku6iTtSp34HzM+hr+ZZD4Pex-N10qehfXXhHQjA@mail.gmail.com>
Message-ID: <201703231949.EDJ81789.FHMQOFLFOtVOJS@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Dmitry Vyukov wrote:
> Hello,
> 
> I've got the following double-free report in superblock_doinit while
> running syzkaller fuzzer.
> Note the preceding injected failure in kmalloc, most likely that the root cause.

Thank you for reporting.

selinux_parse_opts_str() and smack_parse_opts_str() forgot to set
opts->mnt_opts to NULL after kfree() at

if (!opts->mnt_opts_flags) {
	kfree(opts->mnt_opts);
	goto out_err;
}

and caused double free at

if (opts->mnt_opts)
	for (i = 0; i < opts->num_mnt_opts; i++)
		kfree(opts->mnt_opts[i]);

in security_free_mnt_opts().
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
