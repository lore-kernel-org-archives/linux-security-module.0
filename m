From: keescook@chromium.org (Kees Cook)
Date: Fri, 11 Aug 2017 15:05:12 -0700
Subject: [PATCH v4 0/4] seccomp: Implement SECCOMP_RET_KILL_PROCESS action
Message-ID: <1502489117-70522-1-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This series is the result of Fabricio, Tyler, Will and I going around a
few times on possible solutions for finding a way to enhance RET_KILL
to kill the process group. There's a lot of ways this could be done,
but I wanted something that felt cleanest. My sense of what constitutes
"clean" has shifted a few times, and after continually running into
weird corner cases, I decided to make changes to the seccomp action mask,
which shouldn't be too invasive to userspace as it turns out. Everything
else becomes much easier, especially after being able to use Tyler's
new SECCOMP_GET_ACTION_AVAIL operation.

This renames SECCOMP_RET_KILL to SECCOMP_RET_KILL_THREAD and adds
SECCOMP_RET_KILL_PROCESS.

Please take a look!

Thanks,

-Kees

v4:
- basically only kept the selftests, tossed everything else
- expanded SECCOMP_RET_ACTION mask into SECCOMP_RET_ACTION_FULL
- renamed SECCOMP_RET_KILL to SECCOMP_RET_KILL_THREAD
- added SECCOMP_RET_KILL_PROCESS as "-1" value, below 0 (RET_KILL)
- use signed tests in the kernel for seccomp actions

v3:
- adjust seccomp_run_filters() to avoid later filters from masking
  kill-process RET_KILL actions (drewry)
- add test for masked RET_KILL.

v2:
- moved kill_process bool into struct padding gap (tyhicks)
- improved comments/docs in various places for clarify (tyhicks)
- use ASSERT_TRUE() for WIFEXITED and WIFSIGNALLED (tyhicks)
- adding Reviewed-bys from tyhicks

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
