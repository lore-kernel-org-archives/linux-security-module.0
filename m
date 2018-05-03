From: dave.hansen@intel.com (Dave Hansen)
Date: Thu, 3 May 2018 14:55:23 -0700
Subject: Correct way to access the physmap? - Was: Re: [PATCH 7/9] Pmalloc
	Rare Write: modify selected pools
In-Reply-To: <035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
	<20180423125458.5338-8-igor.stoppa@huawei.com>
	<20180424115050.GD26636@bombadil.infradead.org>
	<035f2bba-ebb1-06a0-fb88-3d40f7e484a7@gmail.com>
Message-ID: <ef116557-1fb1-780e-2480-3eef9052b609@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/03/2018 02:52 PM, Igor Stoppa wrote:
> At the end of the summit, we agreed that I would go through the physmap.

Do you mean the kernel linear map?  That's just another name for the
virtual address that you get back from page_to_virt():

	int *j = page_to_virt(vmalloc_to_page(i));
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
