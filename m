Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215353;
	b=4CiD55i/aHieJQ6GzMx4AZ+fP38fBN7G7NdfIB7yZf3UWr8PjPsxfPRqglgmeM+/jE9b
	 JszWaq3UOvDh08wv6wpt5ZloBOhlNOupmadrsRsoigvM9ElQFfxZFWBgAOaSSQxI7dfE9
	 DFrsWs+swhAIFjXXRzf+ucUOg+u2qyEWfwDYLdUUODpAKYYdh+ZUQGNyqDdfWdAXJhzbv
	 /QH15aHXzAh/gA2xupecfA0jjGLl1k+QARc2MIed+AKTQBQUIBw6NSORjvPRs2i4y4XTO
	 s+m5I+mu1yMyDxq+Qp0mnUzI3btKL6jt4UQve60Wjn6HCQZk1/jA93fmuuyTo6IgGIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215353;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=dF7x4L6CgRyPJLEoJCQrQ4pP7smVInKwSeYvbcT8/HI=;
	b=FmnMbrf6EoJMbuYsLmYQq3/cFpgA+Abu0l4HYm/5mtj8stu/VYNugstS4U1fkFmIb+50
	 LeqaRr42U0pm+4oCVh7dswo3Tdo2HWpRTeC1HNSSrKW6OR/8vK0jS/g3IxoV6njsrRoZN
	 Bo3i3f8e2RxoyKPCHoKSylVi9M7lxzVxj3AkAf7u9vGcMyr4+aNhzZtGg2GwyH4hM2F2+
	 0BVcQLiEMnX6XA7c8R4jsTNczK5xCncRJoOV/BW7Waayp1QBu2hpSxiF2/ONgeQ3YxhCI
	 eInxyBX/tHQsNOyaEwC7+yT+l6R4NvcycPOsVp+sQjgeXrh2lz2i6B5zh5k1e02Xd+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b="R9/kCXlh";
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A148606D803;
	Mon,  9 Nov 2026 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A148606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=R9/kCXlh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dF7x4L6CgRyPJLEoJCQrQ4pP7smVInKwSeYvbcT8/HI=; b=R9/kCXlhPKlWEYGNLPEHOjxGos
	jfHH1rVhwiBDTwUo+LFfGN6U67Y0i/mw6jMLBadDIN3n89LzJnc27/S1NgfZ8mZg8a4oG2IMECGXe
	QO9v62nQhwlK2Qwq4x4pfOzyCTdnn1gLRnyp74dexZ1g3IP8drv62Z22dR35kiWgeW/JvdGBXMers
	2RcsrpuC8mJ1gfuaGJYEMGf3dcdL7JfF0moNvoc4u6T6oyBhmrMd1VdzQ4rb0WU4ts7CqKNwYnov0
	NvVorK1ukJx2Zf7z1t4/e4gVHxlpFHJYgB8n+dXe2meBeyRdJHfWpKELZ0X3NW2aQgdnGXS95qwWv
	eWiL32hw==;
Received: from [::1] (port=36922 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xQLNB-00000007yi4-0YGr;
	Mon, 09 Nov 2026 10:09:04 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 10:08:59 +0100
From: nicolas.bouchinet@oss.cyber.gouv.fr
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: xiujianfeng@huawei.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next 0/9] lockdown: fix the securityfs interface and add
 tests
In-Reply-To: <20261103082421.3033195-1-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <f118d32f369dff7182956b64e6bc1dd8@oss.cyber.gouv.fr>
X-Sender: nicolas.bouchinet@oss.cyber.gouv.fr
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Cai,

Thanks for your contribution.
> The lockdown LSM exposes /sys/kernel/security/lockdown, but the file is
> not documented and has no selftest.  While looking at the interface we
> also found a configuration bug and several accumulated cleanups.
> 
> The series is organized as follows:
> 
>   - patches 1-2 are small cleanups in lockdown_write(): stop scanning
>     after the matching level and drop an update to a length variable
>     that is not used afterwards.
>   - patch 3 replaces sprintf() with scnprintf() so that the status
>     buffer is bounded explicitly if more levels are added later.
>   - patch 4 makes the LSM select SECURITYFS.  Without it, a kernel
>     built with CONFIG_SECURITYFS=n logs "failed LSM lockdown core
>     initcall with errno -19" and does not create the file advertised
>     by the Kconfig help text.
>   - patch 5 removes LSM_AUDIT_DATA_LOCKDOWN and its formatting code,
>     which became dead when the SELinux lockdown implementation was
>     removed by commit f5d0e5e9d72d.
>   - patches 6-7 drop an unused include, simplify the securityfs
>     registration, and move lockdown_reasons[] next to its only user.
>   - patch 8 documents the ABI and adds the new file to the LOCKDOWN
>     SECURITY MODULE entry in MAINTAINERS.
>   - patch 9 adds a kselftest covering the read format, invalid levels,
>     and the rejection of the current or a lower level.
> 
> The only functional change is patch 4; the rest are cleanups,
> documentation, or test coverage.  The selftest never escalates
> lockdown on the machine where it runs.
> 
> Cai Xinchen (8):
>   lockdown: Add break in lockdown_write
>   lockdown: bound the status string with scnprintf
>   lockdown: select SECURITYFS
>   lsm: remove unused lockdown audit data
>   lockdown: drop an unused include and simplify secfs init
>   lockdown: move lockdown_reasons next to its only user
>   Documentation/ABI: document the lockdown securityfs file
>   selftests/lsm: add lockdown securityfs test
> 
> Kalevi Kolttonen (1):
>   lockdown: remove useless decrement operation
> 
>  Documentation/ABI/testing/securityfs-lockdown |  41 ++++
>  MAINTAINERS                                   |   1 +
>  include/linux/lsm_audit.h                     |   2 -
>  include/linux/security.h                      |   2 -
>  security/lockdown/Kconfig                     |   1 +
>  security/lockdown/lockdown.c                  |  63 +++++--
>  security/lsm_audit.c                          |   4 -
>  security/security.c                           |  40 ----
>  tools/testing/selftests/lsm/Makefile          |   3 +-
>  tools/testing/selftests/lsm/common.c          |  35 +++-
>  tools/testing/selftests/lsm/common.h          |   2 +
>  tools/testing/selftests/lsm/lockdown_test.c   | 176 ++++++++++++++++++
>  12 files changed, 300 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/ABI/testing/securityfs-lockdown
>  create mode 100644 tools/testing/selftests/lsm/lockdown_test.c

Those looks good to me, I've added comments in patch 9.
I'm not at work this week so I'll tests your series next monday. Sorry
for the inconvenience.

Best regards,

Nicolas
