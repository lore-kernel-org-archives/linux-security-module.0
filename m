From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Fri, 7 Sep 2018 13:50:14 -0400
Subject: [PATCH 3/6] selinux: convert to kvmalloc
In-Reply-To: <89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
	<20180907165635.8469-4-kent.overstreet@gmail.com>
	<89c167ff-91d3-7a27-78c6-82710bb11771@I-love.SAKURA.ne.jp>
Message-ID: <20180907175014.GA29485@kmo-pixel>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 08, 2018 at 02:08:03AM +0900, Tetsuo Handa wrote:
> On 2018/09/08 1:56, Kent Overstreet wrote:
> > @@ -329,8 +328,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> >  		nslot = MAX_AVTAB_HASH_BUCKETS;
> >  	mask = nslot - 1;
> >  
> > -	h->htable = flex_array_alloc(sizeof(struct avtab_node *), nslot,
> > -				     GFP_KERNEL | __GFP_ZERO);
> > +	h->htable = kvmalloc_array(nslot, sizeof(void *), GFP_KERNEL);
> >  	if (!h->htable)
> >  		return -ENOMEM;
> >  
> 
> kvmalloc_array() does not imply __GFP_ZERO.

Thanks, fixed
