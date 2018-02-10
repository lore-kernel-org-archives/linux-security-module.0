From: willy@infradead.org (Matthew Wilcox)
Date: Fri, 9 Feb 2018 19:37:14 -0800
Subject: [PATCH 5/6] Documentation for Pmalloc
In-Reply-To: <56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
References: <20180130151446.24698-1-igor.stoppa@huawei.com>
	<20180130151446.24698-6-igor.stoppa@huawei.com>
	<20180130100852.2213b94d@lwn.net>
	<56eb3e0d-d74d-737a-9f85-fead2c40c17c@huawei.com>
Message-ID: <20180210033714.GA12711@bombadil.infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Feb 02, 2018 at 05:56:29PM +0200, Igor Stoppa wrote:
> But what is the license for the documentation? It's not code, so GPL
> seems wrong. Creative commons?

I've done this as the first line of my new documentation files:

.. SPDX-License-Identifier: CC-BY-SA-4.0

I think this is the CC license that's closest in spirit to the GPL without
the unintended consequences of the GPL when used on documentation.  The
GFDL seems to be out of favour these days.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
