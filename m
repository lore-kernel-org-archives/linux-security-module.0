From: james.l.morris@oracle.com (James Morris)
Date: Thu, 30 Mar 2017 09:32:35 +1100
Subject: [PATCH] TOMOYO: use designated initializers
In-Reply-To: <CAGXu5j+kUbEcAcCKZT09pHFxWTYkiNqnxGKCyrLhuYLeiSemZw@mail.gmail.com>
References: <20161217010522.GA140690@beast>
	<201612171155.EDG30258.QOtFMSOJFFLOVH@I-love.SAKURA.ne.jp>
	<CAGXu5j+kUbEcAcCKZT09pHFxWTYkiNqnxGKCyrLhuYLeiSemZw@mail.gmail.com>
Message-ID: <7b574e9d-e877-f73b-9cfc-6f6f0766a30d@oracle.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 30/03/17 07:45, Kees Cook wrote:
> On Fri, Dec 16, 2016 at 6:55 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> Kees Cook wrote:
>>> Prepare to mark sensitive kernel structures for randomization by making
>>> sure they're using designated initializers. These were identified during
>>> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
>>> extracted from grsecurity.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  security/tomoyo/file.c   | 12 ++++++------
>>>  security/tomoyo/tomoyo.c | 20 ++++++++++----------
>>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>
>> James, please apply to linux-security.git .
>
> Friendly ping. :) James, I don't think this ever got into -next?

Please resend it.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
