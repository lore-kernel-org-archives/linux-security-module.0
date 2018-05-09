From: jmorris@namei.org (James Morris)
Date: Thu, 10 May 2018 05:21:37 +1000 (AEST)
Subject: [PATCH v3 1/3] big key: get rid of stack array allocation
In-Reply-To: <alpine.LRH.2.21.1805100519200.12749@namei.org>
References: <20180424202639.19830-1-tycho@tycho.ws>
	<CAGXu5jLL7NeX+zUNqcYW_LDF87CPg-5Z4R5+FZ5uPDT-sTisng@mail.gmail.com>
	<alpine.LRH.2.21.1805100519200.12749@namei.org>
Message-ID: <alpine.LRH.2.21.1805100520100.12749@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 10 May 2018, James Morris wrote:

> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > James, are these something you can take into your tree?
> 
> Sure!

Although, normally, these would likely come in to mine via David's tree.  

Please do that unless there's a special case here.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
