From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 21 Nov 2017 10:53:33 -0500
Subject: IMA appraisal master plan?
In-Reply-To: <e84b74a4-be06-8c15-5bbe-c4e7ee8abe42@huawei.com>
References: <20171107151742.25122-1-mjg59@google.com>
	<1510766803.5979.17.camel@intel.com>
	<CACdnJusRutc4j7z+w6pZ0tooeAPcq=Vky_evF=X61AK_ivAEqg@mail.gmail.com>
	<1510770065.5979.21.camel@intel.com>
	<alpine.LFD.2.20.1711161101360.27132@localhost>
	<CACdnJuv=YDngm5HqJT9sfM01AVoZUaf8_uu-ygo+h8nNjtsDeA@mail.gmail.com>
	<1510798382.3711.389.camel@linux.vnet.ibm.com>
	<8bbaea89-336c-d14b-2ed8-44cd0a0d3ed1@huawei.com>
	<1510837595.3711.420.camel@linux.vnet.ibm.com>
	<a88aff89-1e75-9019-4394-640f5fb318da@huawei.com>
	<alpine.LFD.2.20.1711200746120.25470@localhost>
	<1511173252.5979.45.camel@intel.com>
	<fd3f5cd3-a6a8-a540-f634-4ac489a171e8@huawei.com>
	<1511273148.4729.206.camel@linux.vnet.ibm.com>
	<e84b74a4-be06-8c15-5bbe-c4e7ee8abe42@huawei.com>
Message-ID: <1511279613.4729.219.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-11-21 at 16:25 +0100, Roberto Sassu wrote:

> In the next version of the patch set 'ima: preserve integrity of dynamic
> data', I will introduce the policy low watermark for objects. Instead of
> denying writing of mutable files by processes outside the TCB, IMA will
> allow the operation and demote those files (remove the HMAC).

There has been no consensus for the existing patch set you've posted.
In fact, everyone who has responded said to make it a separate LSM.
Extending the patch set makes no sense.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
