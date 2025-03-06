Received: from outgoing1.cpt4.host-h.net (outgoing1.cpt4.host-h.net [197.189.247.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B9202F7C
	for <linux-security-module@vger.kernel.org>; Thu,  6 Mar 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=197.189.247.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302347; cv=none; b=rKefMxBhU1ckZ+vezi28Az7+D9EoVYc6dRE03QSP64RlR3OsPAgCLW20mWKUtEfBsUmZs/V8iZSj4YemGNL9TGUiG2zXZX4maWUxTbBXV1PpPl5d1IMIp2+DjgXX5Eg3kTFmFzzLb74w7OR7CxXEsFxxNlDVmzxN5a2EG+OKeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302347; c=relaxed/simple;
	bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ot4D9M7CCzxR968Nrd9Q5pbtx0C3X17ANAJUn+slgVvPY7Oi1f7ZTgkoJkwA2q47Yo+59KDTvlM2+OzVCchVgwk6qTEHJ43v5jrPttiPUwiQMuTAO4Axk9SVoGANVtKhRYcCRza0vVc3WMg2f0r1z1Qb+V11oJ13wrH6Jr7pSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za; spf=pass smtp.mailfrom=delugo.co.za; dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b=fwtHEr3Z; arc=none smtp.client-ip=197.189.247.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b="fwtHEr3Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=fw
	tHEr3ZSIHOwWIKEPebj9JS/+1ME3VusP1PwAkr9QLCLgpZ26gXwTRHCALYHepdjE4w/mxDsDfk8QT
	Vi2GAOtA7/Bd2t6uBpDyIG/tZx8hXZTMCw5DPTcJaeqUtKIBeJ3fL0Ls5SRATOdb6+72+nEPnnoYG
	7+1Wj/2m6Z2JmQzam6DXLgyuQT9qHqv4zW3jkSK5+AVWrCLrMCwkBGBxb/rSKLe7XZaFORZJ12Kvi
	QW6qJ7wNRljmW8A8aVFr9gBXNMqwBse0K3Un2afZSqvta3o8PGKSGysDL4K+WTM4R45lN3p03ZzsK
	5Wan3D+ygOnudzr7z/a9QemxSfFvbXeg==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam1-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqKHb-001Ufq-UV
	for linux-security-module@vger.kernel.org; Fri, 07 Mar 2025 01:05:41 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK54-0000000Dm2d-2zgk
	for linux-security-module@vger.kernel.org;
	Fri, 07 Mar 2025 00:52:43 +0200
Reply-To: barry@investorstrustco.net
From: Barry <orders@delugo.co.za>
To: linux-security-module@vger.kernel.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:52:41 +0000
Message-ID: <20250306223012.65CEFDE1D0C500F3@delugo.co.za>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zVMa2hcQPbXPlbMCsY+hkkq9cT4r4LC0gkQwZss7ZfdvSI
 QWGhDYOqY2O5fqfx9M7XFT0qB5tFv92nRX4mJdp7UUlLXMUeAXT7hcGmFUnSlv0+BnD7wi70qQBB
 Bsu5GMahLqLPt2D6hJ605Bnjj1q6iCsJyqSmvP2BysP8HrSPvrHARmuVDmgPGNNuts+ba30rnvUy
 zoTfAGEbL5I354EAw8VSKe5hYjiYkc7xjE70WreMPUhTBWui6U/2qinoPDthn6sps0oXop0Wpl2m
 +lnlLYyKfoR+hbZIJAc+0m+mU5EyYYf7TmlI3iEcqXK4A61ChHMQHCMEWTX9HEhwSP4/MSl+mev0
 M9cO0xP2892D0fA6hpTapNg/3VwnapSOnzMvfUiXer9Hk+cBCIH95/C9L4QFy0eB/isP83e9uHLE
 BeHTPI/rzJIRbhotX0RECi6mGIdkjXgJzNr4g6HQm7Ihb/f3QhLRbOgisvi5VU9eNCzoJDM55WJG
 VWcFLzKvCHLdZh03ExTqDquACpNsmDrlcntZzD+8euQ3PTJH+fGZGHMcN6qoXPjenLhIOF1oeRYQ
 IKkaWXerM1u+fwXJu+tuGEDHQue2QZHF055tGS+SvSlfJF3VFFhgaOmHSC78Ngi9P+5Lf0oV1WuF
 nNMdSZz/eBksJ0GzgEY832zb4/bETantKr6+crm+rffkaQ6ZgOhecDS00P8Fc8OWE6jtCYt+lNx7
 b76pl5pevnFznkcIx8H+6Fv7XKRVCdPrl4S6mURwxc3o2KyPRa0Vg6NfcXRhctgzcDoFd+96Xw4Q
 UNtTnX41RgS4hAw4xf8QWxdHHi13boj4UU49ILZd2HDXpRdrzviI9CRCIiamRgyDQudwNxUd81Og
 MWXFNTBQD09QdRCR27r9HYUzziTFhEVK8LUg5R4IAJ8DqZLMftAhiZ5VBhI+iM6gPdcRK2u+Vqin
 8bA0g/W+lOecImzPxJzzUQScBEigpxA1CSufo+L91Hr9qg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker
