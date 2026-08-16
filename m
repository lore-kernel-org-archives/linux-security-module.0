Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE820125F;
	Sun, 16 Aug 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786902975; cv=none; b=RprDaC0J0ESZ+d+NiacWgh4NDarV2jY12GBcDjouMyF8XF9WF/b94fAx9p1CJwT3hrqZVjfBpRvUPV1FMsFd4saaT1NwrMK5X/lR2fkKgWWbzbexO/mXUlYnG9mViPGv1QBwHbgYMmKNkMhY+aDEEKZIG+7+jkVRUwDlCOV7pwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786902975; c=relaxed/simple;
	bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXHE6XHeCX+Ep1kbBmJ2NyJan7FAjp5wNxEvbRslNYhi0ZXPuCpdfxZZD4FoRT6kJ23JdBOSYEpSrSuwe+6rDFOkm92PYjoloYbC4AZ+k2KXGdpOad4pzttVHs5ZGVTf3AOFkJicdwwCMnNrQGiDwHzjoZzoBuXeo4YZoQQPoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=STIMPVZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbCF+Ums; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="STIMPVZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbCF+Ums"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 261C2EC012C;
	Sun, 16 Aug 2026 13:56:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 16 Aug 2026 13:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786902972;
	 x=1786989372; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=
	STIMPVZ1rnbkOfZufJur5k0XcVhH1crVBeWUq/QcXDU3QGt76yu+Z7T+fwbz47P0
	m4BjDcyajJEWGOcHcOVAjKJEmsi8mlmBoDNWuomwR+JjS3SEwlZUwnt5FnH3Zje8
	FOSN0Qdt9izsZHo5pY2zqqX8/bBIvokXPDqIfCblOb6B+yd/8Odpe63EUNz66jQg
	RvrkGcVItEnwPTlOi1T59Ypm4LEkYbj2zBDKMjifN2iMQmwAqu+btpNmErhb9z86
	2WsMTjNh+GxmGDDHIZk5/ot3mBlGqrVPLef9JDF0k9KSHIkx5V2N1DFqfD47GrKh
	bOKRVARjSqxnMtELScanKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786902972; x=
	1786989372; bh=EyEbculfdmcKB1EZX0QglINCttopCIL5evClcdTV5Ik=; b=l
	bCF+UmsMLvOg+w2js+8UCIl7Cf7Tdq85jQFPXAktzyKPe8TxVfCIhrsvC26mclct
	fRfyMs+9Bly9sf4JD2GSrczQaptvnWKezBN8cJiAPit/HcAzEX6WtRMVa3ymRepz
	gU1IOQ8Xfrx3HoZBs3opcUYCDkzYLCAzOiiv82D8iSqgj33VlXR2zOQd220TaBIl
	LlBMqtljPblODdumM9stqfeTUpMzSXfB+TFGWXhokfe+LtPxL1QfoiGWhnDMBZRB
	Tl3g0IpiOOsPXPQuggjYasjddB1D2iLAsr7TPnPJN2l0tOC4YsezfpN3bj3L05Od
	08YsK8sJF490Ea+Tzefzg==
X-ME-Sender: <xms:u_mBauJMHQFg4Gzc3P8lK2QIzcxDd9K3cZnWgYEZ8eMOC4IercGxBQ>
    <xme:u_mBaj_WBIIpehCl_cGcs-Gp0AF-OzmQZs1q6zxhPAleJ1Uxlqsi7UKf0KmR-o85d
    b-b9VNuwdXbmXaTjgdiHgvVSORxo4ZiwuQyDgeJ61LU4sy8JFeFERd2>
X-ME-Received: <xmr:u_mBapII4YU8uojZKsD8UyawJN1tYtx4Wm2oGgxkw1_AOZuJMNX-uj4-StHaSlM>
X-ME-Proxy-Cause: dmFkZTEQParPBFx6CXlgknqGvzH0hcD8cyYRgvwZo8mxOb/KZjrnBXZ2/19s3Fqzov8swB
    a5iF8Sb/2J5Ntsf4FtAn6jY47gQAZ5SIj5kFzouqJZdUv9FkPS62eaMaLcGMjESQtWvkXF
    BURM+8ZumaUk2E3mLt0w2TOQGTNgA2LhbiXjUFYcaC4F48A00sf0ogwSmODDKODtjWy5WC
    mG83DVkUEAAAD97OZx6+WDhd9AN3DRmU0eDgLToPn34SpFyxFJaeB9ZJD0jarDZyDi6zXV
    l/bAbqkvAkGwVzvSRvISKBU+rCksT9fqU3F0tXp8rNLesz/OeL1NBI5nbSN4Dm1QIqJ/Bd
    l0MtG8iOXq2APU1Lnn7iyFC3j8moVyKCASIa4xUWxDFoJD2EMMgadMdJaxRoYKqLuuQGV4
    rM66wKHJVACBY9Ezi74PdUWIssn0zbhhwtjiKTmjIhGmEkiatwTyW/gdNCMMMRc3jIo0bU
    38bSUAt4s8acb30kVOKvsx0Eh4+osoh+PFt7nSpOKvllPFWc/oCStfCEyt8Bwv1MXE9NWL
    GTEov10dYLs5BS+zZ66pvlnvN4ND7N0hkbeYizKmFWSrMoFdKC/R8TzwDNwYGF8ubXjKpM
    +Wcdb/jGBbDq89kZqNl/bXBP6dH9Wnnd0F+qHJo8OqiqrUbgVyges5KuAj7A
X-ME-Proxy: <xmx:u_mBagkgsv-4zVkqfMQbr1TR4FLXGf8glkFmSuznimeZLvCXAsYG_Q>
    <xmx:u_mBalPN1sX2tF4z1z5m_8bsYozW-i4tNO1yKv1LiBoTOSzsWEE3RA>
    <xmx:u_mBau3knpbjmi1YdDGhF3qqeOu_685suGKHzu8JrX8byu7MgGvJqQ>
    <xmx:u_mBasn54hYzdzJ8tz1zZ9X_pMj-NtyUjO6AvbFj2x2qjNQhRokcjA>
    <xmx:vPmBanfFI_o2oUq582s2J1E3-0lIjPJQi6szwGeD0yolDuVHh_EcY5W3>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 13:56:11 -0400 (EDT)
Message-ID: <e313100d-6e27-4f0d-9b24-5cf740938f91@maowtm.org>
Date: Sun, 16 Aug 2026 18:56:09 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/19] landlock: Prepare ruleset and domain type split
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: kernel-team@cloudflare.com, linux-security-module@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-2-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260811094338.288094-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tingmao Wang <m@maowtm.org>
