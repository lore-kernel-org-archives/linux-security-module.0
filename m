From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 11:46:23 -0400
Subject: [PATCH 01/13] selinux: Cleanup printk logging in conditional
In-Reply-To: <ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-2-peter.enderborg@sony.com>
	<a85d28e8cbd32acda21424ab6a46089f26969671.camel@perches.com>
	<ef97b4b2-35da-7642-aa9d-de3e968cfb81@sony.com>
Message-ID: <CAHC9VhR=1Z6sPJ=oetCg0fGFGb7yKq3OxRATeo15jhqMY5JoQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 13, 2018 at 2:23 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 06/12/2018 04:38 PM, Joe Perches wrote:
> > On Tue, 2018-06-12 at 10:09 +0200, Peter Enderborg wrote:
> >> Replace printk with pr_* to avoid checkpatch warnings.
> > I believe it would be nicer to remove the
> > "SELinux: " prefix embbeded in each format
> > and use a specific
> >
> > #define pr_fmt(fmt) "SELinux: " fmt
> >
> > to automatically prefix these formats.
>
> I cant argument about that, however some of the warnings and debug prints in this set does not have this
> so it will then change the actual output. (And I also think that they should have a the prefix, but I don't
> know why they don't) So I am not sure if it appropriate for a cleanup patch, it supposed to have no functional change.

As others have mentioned, I think this patch is still a step forward
so I'm going to go ahead and merge it; thanks Peter.

As far as the prefix, or lack of, is concerned, that's probably an
oversight that we should fix at some point, but we would need to look
at each instance to verify.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
