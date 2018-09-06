From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Sep 2018 17:13:05 -0700
Subject: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <alpine.LRH.2.21.1809061008210.23269@namei.org>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
	<CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
	<2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com>
	<CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
	<alpine.LRH.2.21.1809061008210.23269@namei.org>
Message-ID: <CAGXu5jJKovNX9SMEPrawx=BqzkPHXay-WSfidQF830hqAGZ-eg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 5, 2018 at 5:08 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 5 Sep 2018, Kees Cook wrote:
>
>> On Wed, Sep 5, 2018 at 3:49 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
>> >
>> >
>> > On 06/09/18 01:23, Kees Cook wrote:
>> >
>> >> Should I take this, or is it part of your series going somewhere else?
>> >
>> >
>> > It turned out it doesn't really work to have a generic series against 20
>> > trees :-/
>>
>> I know that pain very well!
>>
>> > I'm submitting them individually to each subsystem.
>> > So this one is just for security.
>>
>> Sounds good.
>>
>> James, can you take this directly, or would you prefer a pull request from me?
>
> I'll take it with your ack.

Already included! :) (This was a v2, split from a separate series, so
Igor already included my Ack from the other thread.)

But, for completeness:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
