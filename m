From: willy@infradead.org (Matthew Wilcox)
Date: Tue, 13 Mar 2018 15:00:40 -0700
Subject: [PATCH 4/8] struct page: add field for vm_struct
In-Reply-To: <20180313214554.28521-5-igor.stoppa@huawei.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
	<20180313214554.28521-5-igor.stoppa@huawei.com>
Message-ID: <20180313220040.GA15791@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 13, 2018 at 11:45:50PM +0200, Igor Stoppa wrote:
> When a page is used for virtual memory, it is often necessary to obtain
> a handler to the corresponding vm_struct, which refers to the virtually
> continuous area generated when invoking vmalloc.
> 
> The struct page has a "mapping" field, which can be re-used, to store a
> pointer to the parent area.
> 
> This will avoid more expensive searches, later on.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Regardless of the fate of the rest of this patchset, this makes sense
and we should have this.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
