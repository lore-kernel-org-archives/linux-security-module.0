From: keescook@chromium.org (Kees Cook)
Date: Wed,  2 Aug 2017 20:19:09 -0700
Subject: [PATCH 0/4] seccomp: Add SECCOMP_FILTER_FLAG_KILL_PROCESS
Message-ID: <1501730353-46840-1-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This series is the result of Fabricio and I going around a few times
on possible solutions for finding a way to enhance RET_KILL to kill
the process group. There's a lot of ways this could be done, but I
wanted something that felt cleanest. As it happens, Tyler's recent
patch series for logging improvement also needs to know a litte bit
more during filter runs, and the solution for both is to pass back
the matched filter. This lets us examine it here for RET_KILL and
in the future for logging changes.

The filter passing is patch 1, the new flag for RET_KILL is patch 2.
Some test refactoring is in patch 3 for the RET_DATA ordering, and
patch 4 is the test for the new RET_KILL flag.

Please take a look!

Thanks,

-Kees

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
