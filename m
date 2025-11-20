Received: from cstnet.cn (smtp20.cstnet.cn [159.226.251.20])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855053093BA;
	Thu, 20 Nov 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635975; cv=none; b=Ri6aaLHjUB6szg0Lgto3I1BpSRSP5zFUuMfKOfDcPXtevcyOuyLgehlm9a8pPJAeFvTN9ZU0WBWjx0dKVNG3tL/4/cwM8hk6eEb82+PKT04MjVDNefSbFUJhMPTvqG80xgQ0lM3adgqmElr79zrmVZp/urUciO2VQrA6AY2KcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635975; c=relaxed/simple;
	bh=9nzyk9mNVcHprIrLE1aBJ7fjhWppihHnOAs67iC37BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=aBGZEiU1vedL8UNeB7scFvHuqJzB9YV+K8xxJwSeNr7BPES0GRuy7CBazNTOH7RIPhjBfy7gpMNXUqeMMbVVMSMKnqmvKMHzGRuhbx0xRGDiwPvTFDGEI2MLTCPWkW9f+JOYwa38XLwPg6ZNrroGZVUxeeULNvCZq5AVwzrMZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from xujiakai24$mails.ucas.ac.cn ( [210.73.43.101] ) by
 ajax-webmail-APP-10 (Coremail) ; Thu, 20 Nov 2025 18:52:35 +0800
 (GMT+08:00)
Date: Thu, 20 Nov 2025 18:52:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6K645L2z5Yev?= <xujiakai24@mails.ucas.ac.cn>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: Re: [BUG] landlock: sleeping function called from invalid
 context in hook_sb_delete()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2025 www.mailtech.cn cnic.cn
In-Reply-To: <20251120.c5c17c664315@gnoack.org>
References: <20dd8187.9d18.19a75eadc43.Coremail.xujiakai24@mails.ucas.ac.cn>
 <20251120.c5c17c664315@gnoack.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <94cfae8.22396.19aa0e50801.Coremail.xujiakai24@mails.ucas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowACHcOjz8h5pk2QDAA--.36795W
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/1tbiDAcME2kem3F6OAA
	CsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGVsbG8gR8O8bnRoZXIsCgpUaGFua3MgYSBsb3QgZm9yIHlvdXIgZGV0YWlsZWQgcmVwbHkuCgpZ
b3VyIGV4cGxhbmF0aW9uIG1ha2VzIHBlcmZlY3Qgc2Vuc2UuIEkgYWdyZWUgdGhpcyBpcyBpbmRl
ZWQgYSBmYWxzZSBwb3NpdGl2ZS4KVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCBhbmQgZm9y
IHRoZSBjbGFyaWZpY2F0aW9uLgoKSSBhcHByZWNpYXRlIHlvdXIgdGltZSBhbmQgdGhlIGhlbHBm
dWwgYW5hbHlzaXMuCgpCZXN0IHJlZ2FyZHMsCi1KaWFrYWkK
