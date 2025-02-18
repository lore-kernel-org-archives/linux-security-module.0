Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B91A256E
	for <linux-security-module@vger.kernel.org>; Tue, 18 Feb 2025 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739852659; cv=none; b=sERWYel60YYjNwwVVMvY3sD0zTTLLAnfBRCleT2N9RPcRHuY/HsQIKH6ksBngv7e/XvNvEC+P1R6XQp8d1FLTkOeHnqW6ICe4URUfEN1PohlOcnNgYq08c+ILjtnG8sYYhheh4zOMW1m6UtSk5sUk/8V54OU7NT0CcLWo4fENys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739852659; c=relaxed/simple;
	bh=vUp2f0dUGzyNdCIXClkjciqVJywiWEkvB8XutnkK1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Mn8nl0GVi0WVGFPPUpnVdn0e4jjkL3lnwlaoUd5cPxla6dvLdv7DqRwk8AcljcOoTFWX+y6p6mqm/9ASwxXBhPYmcv/V8yh880vAjAp1YhE0zbCsLa5Q61HwgSskoEGOClgmyMKY1h6T8xGo6u6GK1js7qiDhvdRjMHHQ+JdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9lXuu5u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9lXuu5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739852656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEVwY6828gii5G/EHkyb4svsHTFTS04m4XYv3raJ3OY=;
	b=C9lXuu5uoOxGtINl1GRMApTyd1NU0ODk0WXjcXVc3DaX6WZfCnO6Re1ehPC5zcbuYQ+fil
	wM2UzFUIQ5+KfWGhU0QbW9K2MXX9zUm90wNt6vR4RQD3YMqKxKkhaa6cJQcpAEiThWsgQD
	JqojboBkxLNOUdEdY4nS7K94biv/PLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-fzAP0MCyPn2tE5cfF2uWcA-1; Mon,
 17 Feb 2025 23:24:12 -0500
X-MC-Unique: fzAP0MCyPn2tE5cfF2uWcA-1
X-Mimecast-MFC-AGG-ID: fzAP0MCyPn2tE5cfF2uWcA_1739852650
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B6B180056F;
	Tue, 18 Feb 2025 04:24:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61F6D19560AA;
	Tue, 18 Feb 2025 04:24:05 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:24:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH v7 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z7QLYd5ZFmQuV8Gx@MiWiFi-R3L-srv>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-3-chenste@linux.microsoft.com>
 <6fd5510827a2ebb91aee8c72432e248e967fa5be.camel@linux.ibm.com>
 <47565966-c735-4758-80a5-523fd93adc72@linux.microsoft.com>
 <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7dd78f21a9fa9dc3b6f90eae2668cfe5c7670c7.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/12/25 at 08:03am, Mimi Zohar wrote:
> On Mon, 2025-02-10 at 09:06 -0800, steven chen wrote:
> > On 2/7/2025 11:15 AM, Mimi Zohar wrote:
> > > Hi Steven,
> > > 
> > > On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > > > Currently, the mechanism to map and unmap segments to the kimage
> > > > structure is not available to the subsystems outside of kexec.  This
> > > > functionality is needed when IMA is allocating the memory segments
> > > > during kexec 'load' operation.  Implement functions to map and unmap
> > > > segments to kimage.
> > > > 
> > > > Implement kimage_map_segment() to enable mapping of IMA buffer source
> > > > pages to the kimage structure post kexec 'load'.  This function,
> > > > accepting a kimage pointer, an address, and a size, will gather the
> > > > source pages within the specified address range, create an array of page
> > > > pointers, and map these to a contiguous virtual address range.  The
> > > > function returns the start of this range if successful, or NULL if
> > > > unsuccessful.
> > > > 
> > > > Implement kimage_unmap_segment() for unmapping segments
> > > > using vunmap().
> > > > 
> > > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > I don't recall previously adding my "Reviewed-by" tag.
> > > 
> > > Eric, I'd appreciate your reviewing this and the subsequent patch "[PATCH v7 3/7]
> > > ima: kexec: skip IMA segment validation after kexec soft reboot" in particular.
> > Hi Eric, Could you help to review this patch as Mimi mentioned? Thanks!
> > > 
> > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Steven, since these patches impact kdump, before re-posting the patch set, please
> include the following tags before your Signed-off-by tag on the kexec patches.

Thanks, Mimi.

Yes, Steven, please add me in CC when reposting. Thanks in advance.

I will check this version to see if there's impact on kexec/kdump
from my side.

And by the way, kdump should not need IMA, it's better be disabled by
default. I will have a look and try disabling it in kdump kernel, while
really appreciate it if any IMA expert can do it.

Thanks
Baoquan

