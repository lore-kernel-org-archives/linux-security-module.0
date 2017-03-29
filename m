From: keescook@chromium.org (Kees Cook)
Date: Wed, 29 Mar 2017 13:45:28 -0700
Subject: [PATCH] TOMOYO: use designated initializers
In-Reply-To: <201612171155.EDG30258.QOtFMSOJFFLOVH@I-love.SAKURA.ne.jp>
References: <20161217010522.GA140690@beast>
	<201612171155.EDG30258.QOtFMSOJFFLOVH@I-love.SAKURA.ne.jp>
Message-ID: <CAGXu5j+kUbEcAcCKZT09pHFxWTYkiNqnxGKCyrLhuYLeiSemZw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Dec 16, 2016 at 6:55 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Kees Cook wrote:
>> Prepare to mark sensitive kernel structures for randomization by making
>> sure they're using designated initializers. These were identified during
>> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
>> extracted from grsecurity.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  security/tomoyo/file.c   | 12 ++++++------
>>  security/tomoyo/tomoyo.c | 20 ++++++++++----------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> James, please apply to linux-security.git .

Friendly ping. :) James, I don't think this ever got into -next?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
