From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Wed, 23 May 2018 18:18:45 -0400
Subject: [PATCH 2/6] proc: commit to genradix
In-Reply-To: <20180523112823.GA19987@bombadil.infradead.org>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-2-kent.overstreet@gmail.com>
	<20180523112823.GA19987@bombadil.infradead.org>
Message-ID: <20180523221845.GB23040@kmo-pixel>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 23, 2018 at 04:28:23AM -0700, Matthew Wilcox wrote:
> On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> > @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> >  	unsigned long nr_files, pos, i;
> > -	struct flex_array *fa = NULL;
> > -	struct map_files_info info;
> > +	GENRADIX(struct map_files_info) fa;
> >  	struct map_files_info *p;
> >  	int ret;
> >  
> > +	genradix_init(&fa);
> 
> Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?

Already exists. I kind of prefer not to use it when I don't need to though, and
stick to things that look more like normal declarations instead.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
