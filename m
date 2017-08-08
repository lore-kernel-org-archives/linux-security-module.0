From: keescook@chromium.org (Kees Cook)
Date: Mon, 7 Aug 2017 18:37:04 -0700
Subject: [PATCH 4/4] selftests/seccomp: Test thread vs process killing
In-Reply-To: <2185ad3f-2a08-09b9-2df6-1fa5853506d7@canonical.com>
References: <1501730353-46840-1-git-send-email-keescook@chromium.org>
	<1501730353-46840-5-git-send-email-keescook@chromium.org>
	<2185ad3f-2a08-09b9-2df6-1fa5853506d7@canonical.com>
Message-ID: <CAGXu5jKgOC64uJZBh8NHyHvFTKYtopx6gTXT3GCTPhpuPG82Hw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 7, 2017 at 6:29 PM, Tyler Hicks <tyhicks@canonical.com> wrote:
>> +     /* Only the thread died. Let parent know this thread didn't die. */
>
> This read a little odd to me. How about, "Only the created thread died.
> Let parent know the this creating thread didn't die."?

Sounds good. I've updated this to be more descriptive.

>> +     ASSERT_EQ(1, WIFEXITED(status));
>
> This is probably nitpicky but, after reading the wait(2) man page, I
> feel like this should be ASSERT_TRUE(WIFEXITED(status)) instead of
> comparing to 1. There's no documented guarantee that 1 will be returned.

That's a fair point. I've updated this and WIFSIGNALED now, thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
