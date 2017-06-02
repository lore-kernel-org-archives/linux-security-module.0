From: paul@paul-moore.com (Paul Moore)
Date: Fri, 2 Jun 2017 10:33:43 -0400
Subject: [PATCH security-next 2/2] selinux: use pernet operations for hook
	registration
In-Reply-To: <CAHC9VhTHhiuaL5Lih1ykXX+wib9xyvriMvnoX+tAkpgEOxwCng@mail.gmail.com>
References: <20170421094909.28961-1-fw@strlen.de>
	<20170421094909.28961-3-fw@strlen.de>
	<CAHC9VhTkAp+e2PQV58ARtYk8XZJSadaSZWoQudDX9DfQjnfATQ@mail.gmail.com>
	<CAHC9VhTHhiuaL5Lih1ykXX+wib9xyvriMvnoX+tAkpgEOxwCng@mail.gmail.com>
Message-ID: <CAHC9VhTjfe0rzVDe6v_z55xfzgSx1ANGm_me=6usf=BNpMWpyQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 26, 2017 at 4:47 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 26, 2017 at 4:46 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Fri, Apr 21, 2017 at 5:49 AM, Florian Westphal <fw@strlen.de> wrote:
>>> It will allow us to remove the old netfilter hook api in the near future.
>>>
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>> ---
>>>  security/selinux/hooks.c | 24 ++++++++++++++++++++----
>>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> Looks fine to me, I'm going to queue this up for after the v4.12 merge window.
>
> ... and I just realized that the SELinux list wasn't CC'd on this
> patch, fixing that now.

Merged, thanks.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
