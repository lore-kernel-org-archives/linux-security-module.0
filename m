From: hw.likun@huawei.com (Li Kun)
Date: Thu, 11 May 2017 12:03:46 +0800
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <20170511005947.GH390@ZenIV.linux.org.uk>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<479df139-b2e4-07f8-c7bc-ae6734856ee5@huawei.com>
	<20170511005947.GH390@ZenIV.linux.org.uk>
Message-ID: <714d08bd-c509-8dc1-dd06-ca7b8a9ed7e1@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Maybe i have misunderstood something about the implemention of taking 
rwsem nestedly in kernel.
Ignore my former email plz:)
? 2017/5/11 8:59, Al Viro ??:
> On Thu, May 11, 2017 at 08:34:18AM +0800, Li Kun wrote:
>> Why we don't make some rules like"the fs should use nested i_rwsem in
>> read_iter" instead?
> What "nested i_rwsem"?

-- 
Best Regards
Li Kun

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
