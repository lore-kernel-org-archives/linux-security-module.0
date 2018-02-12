From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 12 Feb 2018 08:28:49 -0700
Subject: [PATCH 5/6] Documentation for Pmalloc
In-Reply-To: <20180210033714.GA12711@bombadil.infradead.org>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-6-igor.stoppa@huawei.com>
	<20180130100852.2213b94d@lwn.net>
	<56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
	<20180210033714.GA12711@bombadil.infradead.org>
Message-ID: <20180212082849.1377f7e6@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 9 Feb 2018 19:37:14 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> I've done this as the first line of my new documentation files:
> 
> .. SPDX-License-Identifier: CC-BY-SA-4.0
> 
> I think this is the CC license that's closest in spirit to the GPL without
> the unintended consequences of the GPL when used on documentation.  The
> GFDL seems to be out of favour these days.

I think that's a great license.  I still fear that it is not suitable for
kernel documentation, though, especially when we produce documents that
include significant text from the (GPL-licensed) kernel source.  The
result is almost certainly not distributable, and I don't think that's a
good thing.  The GPL is not perfect for documentation, but I don't think
that we have a better alternative for in-kernel docs.

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
