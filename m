From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 23 May 2018 04:28:23 -0700
Subject: [PATCH 2/6] proc: commit to genradix
In-Reply-To: <20180523011821.12165-2-kent.overstreet@gmail.com>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
	<20180523011821.12165-2-kent.overstreet@gmail.com>
Message-ID: <20180523112823.GA19987@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	unsigned long nr_files, pos, i;
> -	struct flex_array *fa = NULL;
> -	struct map_files_info info;
> +	GENRADIX(struct map_files_info) fa;
>  	struct map_files_info *p;
>  	int ret;
>  
> +	genradix_init(&fa);

Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
