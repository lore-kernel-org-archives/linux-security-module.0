From: paul@paul-moore.com (Paul Moore)
Date: Fri, 2 Jun 2017 10:36:58 -0400
Subject: [PATCH security-next 1/2] smack: use pernet operations for hook
	registration
In-Reply-To: <20170602084809.GB13569@breakpoint.cc>
References: <20170421094909.28961-1-fw@strlen.de>
	<20170421094909.28961-2-fw@strlen.de>
	<0868b816-939b-12d2-c8aa-a5c8677e1cce@schaufler-ca.com>
	<20170602083322.GA2117@salvia>
	<20170602084809.GB13569@breakpoint.cc>
Message-ID: <CAHC9VhTWmyt1qveNutvv7A4RE0SL2Rx527o--yUEbZx1NURuDQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 2, 2017 at 4:48 AM, Florian Westphal <fw@strlen.de> wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>> On Thu, Jun 01, 2017 at 09:44:05AM -0700, Casey Schaufler wrote:
>> > On 4/21/2017 2:49 AM, Florian Westphal wrote:
>> > > It will allow us to remove the old netfilter hook api in the near future.
>> > >
>> > > Signed-off-by: Florian Westphal <fw@strlen.de>
>> >
>> > I have applied this to git://github.com/cschaufler/smack-next#smack-for-4.13
>>
>> Thanks Casey.
>>
>> We're very much looking forward to getting rid of all these
>> nf_register_hooks() calls all over the tree. This patch helps us going
>> in that direction.
>
> selinux is the last user of this api left in the tree.
> Once Paul applies my patch to convert to pernet_ops we only have to wait until
> all the changes are in linus tree.

Thanks for the reminder, since the SELinux patch didn't go to the
SELinux mailing list it got "lost" during the post-merge-window merge.
Regardless, it's merged into selinux/next and it should go upstream
during the next merge window.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
