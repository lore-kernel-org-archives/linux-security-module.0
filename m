From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 14:29:15 +0200
Subject: [PATCH] tomoyo: fix timestamping for y2038
In-Reply-To: <201710192029.BGI60474.SOOVtFOHMLQFJF@I-love.SAKURA.ne.jp>
References: <20171019095405.689783-1-arnd@arndb.de>
	<201710192029.BGI60474.SOOVtFOHMLQFJF@I-love.SAKURA.ne.jp>
Message-ID: <CAK8P3a12G_eg_6v8Yrq+=WehCmh6Cp0m0GN-+0fr4GVJM+5RHA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 1:29 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Arnd Bergmann wrote:
>> Tomoyo uses an open-coded version of time_to_tm() to create a timestamp
>> from the current time as read by get_seconds(). This will overflow and
>> give wrong results on 32-bit systems in 2038.
>>

>
> Thank you.
>
> Please fold below diff into your patch, for year calculation is wrong.

Done, thanks for spotting this!

>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks!

     Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
