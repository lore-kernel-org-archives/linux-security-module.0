From: paul@paul-moore.com (Paul Moore)
Date: Wed, 12 Sep 2018 22:27:40 -0400
Subject: [PATCH 3/6] selinux: convert to kvmalloc
In-Reply-To: <20180907175014.GA29485@kmo-pixel>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
	<20180907165635.8469-4-kent.overstreet@gmail.com>
	<89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
	<20180907175014.GA29485@kmo-pixel>
Message-ID: <CAHC9VhS=CaEd4quGRv97Dn_2gm7=jMq+nHJvSOnuBtoA=DZvDQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 7, 2018 at 1:50 PM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Sat, Sep 08, 2018 at 02:08:03AM +0900, Tetsuo Handa wrote:
> > On 2018/09/08 1:56, Kent Overstreet wrote:
> > > @@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> > >             nslot = MAX_AVTAB_HASH_BUCKETS;
> > >     mask = nslot - 1;
> > >
> > > -   h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> > > -                                GFP_KERNEL | __GFP_ZERO);
> > > +   h->htable = kvmalloc_array(nslot, sizeof(void *), GFP_KERNEL);
> > >     if (!h->htable)
> > >             return -ENOMEM;
> > >
> >
> > kvmalloc_array() does not imply __GFP_ZERO.
>
> Thanks, fixed

When you resubmit this patch, please make sure you submit it to the
SELinux list (added to the To line above) so that it can be properly
reviewed and merged.

Thanks.

-- 
paul moore
www.paul-moore.com
