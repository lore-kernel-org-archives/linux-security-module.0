From: corbet@lwn.net (Jonathan Corbet)
Date: Tue, 27 Mar 2018 10:55:09 -0600
Subject: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic data
In-Reply-To: <20180327153742.17328-1-igor.stoppa@huawei.com>
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
Message-ID: <20180327105509.62ec0d4d@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 27 Mar 2018 18:37:36 +0300
Igor Stoppa <igor.stoppa@huawei.com> wrote:

> This patch-set introduces the possibility of protecting memory that has
> been allocated dynamically.

One thing that jumps out at me as I look at the patch set is: you do not
include any users of this functionality.  Where do you expect this
allocator to be used?  Actually seeing the API in action would be a useful
addition, I think.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
