Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E6274B37
	for <linux-security-module@vger.kernel.org>; Thu, 27 Nov 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764238747; cv=none; b=BfCUujBWCpzGg7F/15ThrwYn6WzM3pHboxXr1sZCdyE+81QI0lrLT/F3vbcsqZURJP0HRWx3S8KDbEBWBAXQnOmLiomfr5ccQBktS3zHJnsNcRXrEXR1kdluIrgHskPq3oY8T8ucIdBkKAXb4YSiUGbxF1A/2BlgFH2VEuMpK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764238747; c=relaxed/simple;
	bh=5v6DRKnZTxqe762iiqY64ipPAPbhJle8jtkCcG+VZY4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GzuT5ni499W3IgVUcUn0kPxEiOmh8OfL7k6GsXsywo+K3mgmzU8DAVsgoRqmeoBFK6OtZNWkHmzCDPo7UgqgaVw3a5YHaLBkilfgzWXgcpdigFaMWASHNuRr1WAxzk8Tc3SO9jFt/olanOo4cM9zPPbWeicDfb3v52x7iNdopCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=edwv/534; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="edwv/534"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764238743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dvPnaLhntHG/d2RdC9bZ8bYwRVHSPnfj1sCt8Vn6U4k=;
	b=edwv/5346M4Zrk+jt9BA/HVNtKansCBLFcY+AIFtg31SV/U+mPvEzDxs8b6YxyRW66Hiuv
	K7hhS9Zv6rQE88oGIeyH5HADEWQOf84SosprmpXNnSEdY60Ggk4ZcDJbbW0ykBE3K3LDbY
	XbWPEXB8UHGE3S5lcsDQWyBsNkqfkCw=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] apparmor: Replace deprecated strcpy with memcpy in
 gen_symlink_name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <1da23c89-dc2c-41cb-8260-098deb8ae917@canonical.com>
Date: Thu, 27 Nov 2025 11:18:30 +0100
Cc: Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D73FFEAA-F246-4777-8CA8-32807F378423@linux.dev>
References: <20251126165701.97158-2-thorsten.blum@linux.dev>
 <1da23c89-dc2c-41cb-8260-098deb8ae917@canonical.com>
To: John Johansen <john.johansen@canonical.com>
X-Migadu-Flow: FLOW_OUT

On 27. Nov 2025, at 02:32, John Johansen wrote:
> hey Thorsten,
> 
> sorry I have actually pulled these in, and tested them. I didn't send out
> the acks yet because I have another patch that I was waiting on a proper
> signed-off-by: on.
> 
> I am going to have to pull that one so I can push. I'll add acks now but
> the push isn't going to happen for a few hours.
> 
> Acked-by: John Johansen <john.johansen@canonical.com>

Ah sorry for resending then, didn't know you looked at them already.

Thanks,
Thorsten

