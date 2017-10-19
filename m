From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 19 Oct 2017 20:29:01 +0900
Subject: [PATCH] tomoyo: fix timestamping for y2038
In-Reply-To: <20171019095405.689783-1-arnd@arndb.de>
References: <20171019095405.689783-1-arnd@arndb.de>
Message-ID: <201710192029.BGI60474.SOOVtFOHMLQFJF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Arnd Bergmann wrote:
> Tomoyo uses an open-coded version of time_to_tm() to create a timestamp
> from the current time as read by get_seconds(). This will overflow and
> give wrong results on 32-bit systems in 2038.
> 
> To correct this, this changes the code to use ktime_get_real_seconds()
> and the generic time64_to_tm() function that are both y2038-safe.
> Using the library function avoids adding an expensive 64-bit division
> in this code and can benefit from any optimizations we do in common
> code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/tomoyo/audit.c  |  2 +-
>  security/tomoyo/common.c |  4 ++--
>  security/tomoyo/common.h |  2 +-
>  security/tomoyo/util.c   | 39 +++++++++------------------------------
>  4 files changed, 13 insertions(+), 34 deletions(-)

Thank you.

Please fold below diff into your patch, for year calculation is wrong.

  #0047/10/19 20:08:17# profile=1 mode=learning granted=no (global-pid=1) task={ pid=1 ppid=0 uid=0 gid=0 euid=0 egid=0 suid=0 sgid=0 fsuid=0 fsgid=0 } path1={ uid=0 gid=0 ino=639202 major=8 minor=1 perm=0755 type=file } path1.parent={ uid=0 gid=0 ino=155 perm=0755 } exec={ realpath="/usr/lib/systemd/systemd" argc=5 envc=0 argv[]={ "/usr/lib/systemd/systemd" "--switched-root" "--system" "--deserialize" "21" } envp[]={ } }

--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -96,7 +96,7 @@ void tomoyo_convert_time(time64_t time64, struct tomoyo_time *stamp)
 	stamp->hour = tm.tm_hour;
 	stamp->day = tm.tm_mday;
 	stamp->month = tm.tm_mon + 1;
-	stamp->year = tm.tm_year - (1970 - 1900);
+	stamp->year = tm.tm_year + 1900;
 }
 
 /**

Then, you can add

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
