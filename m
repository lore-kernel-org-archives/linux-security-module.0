From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Fri, 5 Jan 2018 15:55:16 +0100
Subject: [GIT PULL] linux-integrity patches for 4.16-security-next-general
In-Reply-To: <1515159816.4418.7.camel@linux.vnet.ibm.com>
References: <1515159816.4418.7.camel@linux.vnet.ibm.com>
Message-ID: <4806797a-bb15-6996-6654-7e21d39b7699@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 1/5/2018 2:43 PM, Mimi Zohar wrote:
> Hi James,
> 
> Mimi Zohar (2):
>        ima: relax requiring a file signature for new files with zero length
>        ima: support new "hash" and "dont_hash" policy actions
Hi Mimi

I think there is an issue in the patch above.

+	/* HASH just sets the digital signature flag, nothing else */
+	if ((action & IMA_HASH) && !(iint->flags & IMA_DIGSIG)) {

IMA_DIGSIG now is an atomic flag.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
