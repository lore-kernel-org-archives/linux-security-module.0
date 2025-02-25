Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964524C80
	for <linux-security-module@vger.kernel.org>; Tue, 25 Feb 2025 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442741; cv=none; b=p5voFWAKM0LWFr7BCMULuF3lwg2sLCnBySx9uemEgNnw3QC4JHUPd9O7Os/DwJJsdVIDhOE+pNe3qDjWc9kTFYdmedWTzyrIZg+9qNFgomOjz5UcE53ndW9Ng/NWfKmwmyWArYPrtoT80jYsVWl6V9MAbAAIl+eFbVfCiTdDBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442741; c=relaxed/simple;
	bh=gNeyILjB/QdS85/GU8LJmYJPDXUZn4Dir5gNKqab82c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN9+6Yd4A+VQelhs5rGv07xagj1FHTZA+5ed+geqPpgcpcxu65PMYGA9kMYmNlOl4X0Fi107Kcdj2KQDdllJnjy7cesb+NSJUCWVrYOqP64KuNhFzEwcFBzvJS4njjaysYQyd8VIOmyQk4YMYPsU0YgQcguZqg3E22Y8xLFsT4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N12SFr2g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N12SFr2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740442738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVAmyR6FHsajLdbtkqXLPF4+Gi6+fbQMI+k10rMIb+Y=;
	b=N12SFr2gOm7QmEIrlsoHBeiaUabHPgmeXm9UsFC77kYyQtttpzyfakZEJdd2JgYNGcUmc3
	KriCiOjGJtLxRG0H9RfJAyWXvSkScF0Z9YiFxo68Jygm7J1l4i2AwQjYmeWxlPF4V+aFeF
	iZ16HQSWJIUxn7Yy04FRiUCKLXn43/g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-T7_wB4RKOL-n5ROr4S-uOw-1; Mon,
 24 Feb 2025 19:18:54 -0500
X-MC-Unique: T7_wB4RKOL-n5ROr4S-uOw-1
X-Mimecast-MFC-AGG-ID: T7_wB4RKOL-n5ROr4S-uOw_1740442732
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA69619373DC;
	Tue, 25 Feb 2025 00:18:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFF71800358;
	Tue, 25 Feb 2025 00:18:48 +0000 (UTC)
Date: Tue, 25 Feb 2025 08:18:44 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/24/25 at 03:05pm, steven chen wrote:
> On 2/23/2025 10:14 PM, Baoquan He wrote:
> > Hi Steve, Mimi,
> > 
> > On 02/18/25 at 02:54pm, steven chen wrote:
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to the subsystems outside of kexec.  This
> > > functionality is needed when IMA is allocating the memory segments
> > > during kexec 'load' operation.  Implement functions to map and unmap
> > > segments to kimage.
> > I am done with the whole patchset understanding. My concern is if this
> > TPM PCRs content can be carried over through newly introduced KHO. I can
> > see that these patchset doesn't introduce too much new code changes,
> > while if many conponents need do this, kexec reboot will be patched all
> > over its body and become ugly and hard to maintain.
> > 
> > Please check Mike Rapoport's v4 patchset to see if IMA can register
> > itself to KHO and do somthing during 2nd kernel init to restore those
> > TPM PCRs content to make sure all measurement logs are read correctly.
> > [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
> > 
> > Thanks
> > Baoquan
> 
> Hi Baoquan,
> 
> For IMA, it appears that there are no current issues with TPM PCRs after a
> kernel soft reboot.

I mean using KHO to hold in 1st kernel and restore the IMA log in 2nd
kernel.

> 
> This patches is used to get currently missed IMA measurements during the
> kexec process copied to new kernel after the kernel soft reboot. I think
> it's ok to leave it at current location: it will be easy to maintain for
> IMA.

Yeah, but I am saying this patchset increase unnecessary code
complexity in kexec code maintaining.

> 
> Overall, for these patches, do you see any major blockers for kexec?
> 
> If you have any specific concerns or need further details, please let me
> know.

I have no concerns for this patchset implementation itself, I saw you using
vmap to maping the possible scattered source pages smartly and taking
the mapped buffer pointers to update later duing kexec jumping. That's very
great and clever method. BUT I am concerned about the solution, if we
can make use of the existed way of KHO to implement it more simply. Could
you please do investigation?

