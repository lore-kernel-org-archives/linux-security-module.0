From: corbet@lwn.net (Jonathan Corbet)
Date: Wed, 21 Feb 2018 15:35:27 -0700
Subject: [PATCH 1/6] genalloc: track beginning of allocations
In-Reply-To: <CAGXu5j+zRQfxRXoSC5G8EjeSkPkpeMxfedJbHEgFyYcyXWmW9w@mail.gmail.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
	<20180212165301.17933-2-igor.stoppa@huawei.com>
	<CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
	<daaee36a-e6c7-8fbf-b758-ecee5106da9a@huawei.com>
	<CAGXu5j+zRQfxRXoSC5G8EjeSkPkpeMxfedJbHEgFyYcyXWmW9w@mail.gmail.com>
Message-ID: <20180221153527.12e7d12c@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 21 Feb 2018 14:29:06 -0800
Kees Cook <keescook@chromium.org> wrote:

> >> I wonder if this might be more readable by splitting the kernel-doc
> >> changes from the bitmap changes? I.e. fix all the kernel-doc in one
> >> patch, and in the following, make the bitmap changes. Maybe it's such
> >> a small part that it doesn't matter, though?  
> >
> > I had the same thought, but then I would have made most of the kerneldoc
> > changes to something that would be altered by the following patch,
> > because it would have made little sense to fix only those parts that
> > would have survived.
> >
> > If it is really a problem to keep them together, I could put these
> > changes in a following patch. Would that be ok?  
> 
> Hmmm... I think keeping it as-is would be better than a trailing
> docs-only patch. Maybe Jon has an opinion?

I would be inclined to agree.  Putting docs changes with the associated
code changes helps to document the patch itself, among other things.  I
wouldn't split them up.

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
