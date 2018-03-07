From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 7 Mar 2018 12:23:47 -0800
Subject: [PATCH v4 1/3] security: Refactor LSM hooks into an array and enum
In-Reply-To: <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
References: <cover.1520407240.git.sargun@sargun.me>
	<3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
	<ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
	<CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
Message-ID: <6326ecfe-83f9-13d8-d59a-58d567726b07@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/7/2018 11:18 AM, Sargun Dhillon wrote:
> On Wed, Mar 7, 2018 at 9:45 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
>>> This commit should have no functional change. It changes the security hook
>>> list heads struct into an array. Additionally, it exposes all of the hooks
>>> via an enum. This loses memory layout randomization as the enum is not
>>> randomized.
>> Please explain why you want to do this. I still dislike it.
>>
> Do you dislike it because of the loss of randomization, or some other reason?

I dislike a huge array of untyped function pointers.
I dislike the loss of type checking in security.c

> The reason for not just having a second list_heads is that it's
> somewhat ugly having to replicate that structure twice -- once for
> dynamic hooks, and once for 'static' hooks.

There was discussion about this some time ago. In the case
where you don't allow dynamic hooks, you mark the lists ro_after_init
whereas in the case with them you don't, but use the locking.


> Instead, we have one enum that LSMs can use and two arrays of heads
> rather than an entire unrolled set of list_heads.

But how is this better? What is the advantage?

>
> If we had a way to randomize this, would it make you comfortable?
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
