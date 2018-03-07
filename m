From: sargun@sargun.me (Sargun Dhillon)
Date: Wed, 7 Mar 2018 11:18:17 -0800
Subject: [PATCH v4 1/3] security: Refactor LSM hooks into an array and enum
In-Reply-To: <ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
References: <cover.1520407240.git.sargun@sargun.me>
	<3646ff78915fcbadbc660257d92921e5442553e0.1520407240.git.sargun@sargun.me>
	<ad43c9ed-9314-1787-911a-f4b206bc5cff@schaufler-ca.com>
Message-ID: <CAMp4zn8gtb7G28F8D_=npc6a7wwp3QMyvXrNKL0LA=EeFxRiKw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 7, 2018 at 9:45 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/6/2018 11:23 PM, Sargun Dhillon wrote:
>> This commit should have no functional change. It changes the security hook
>> list heads struct into an array. Additionally, it exposes all of the hooks
>> via an enum. This loses memory layout randomization as the enum is not
>> randomized.
>
> Please explain why you want to do this. I still dislike it.
>
Do you dislike it because of the loss of randomization, or some other reason?
The reason for not just having a second list_heads is that it's
somewhat ugly having to replicate that structure twice -- once for
dynamic hooks, and once for 'static' hooks.
Instead, we have one enum that LSMs can use and two arrays of heads
rather than an entire unrolled set of list_heads.

If we had a way to randomize this, would it make you comfortable?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
