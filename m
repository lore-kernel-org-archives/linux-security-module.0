Received: from a3-30.smtp-out.eu-west-1.amazonses.com (a3-30.smtp-out.eu-west-1.amazonses.com [54.240.3.30])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287D1E8320;
	Wed, 11 Mar 2026 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.3.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270516; cv=none; b=Qmm0P3HbgJYceRwYfpyZxm4OGc6/ubb7IizdRvo9kq31eSvNwCA1Qfx62OO9neb9EjS9xu42vhV48Ieddjdix36JHU0G41y/dD8D+aYMgEPQTc+edOYX1Ee/b+CN2MwedhZTYJrN/vvmdYQSe4Btnr0gDF60UIEApXJW45yiZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270516; c=relaxed/simple;
	bh=OIJ2jS4dUbUjTgFMfE6GJIzCUFUypmdEg02cOK1iYts=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PI9vFfOrJHeMzxRhsmQfB4nRjc2sYhVZTLUVcCaLvpMCkAiuESM8nYrQVb3Gq22Ulg9NI4FHqINK8CmGmXgNRt3viesyPe2p+j1iD+vAehdFBYCDusyvLOyziEYLmWVAMVKjS6rd93ZPuPtisbicSajXzUL+M4gy/ikqERwDm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com; spf=pass smtp.mailfrom=send.matrixforgelabs.com; dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b=GVjrUhQ5; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=j13RVIP0; arc=none smtp.client-ip=54.240.3.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.matrixforgelabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=matrixforgelabs.com header.i=@matrixforgelabs.com header.b="GVjrUhQ5";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="j13RVIP0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=matrixforgelabs.com; t=1773270513;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=OIJ2jS4dUbUjTgFMfE6GJIzCUFUypmdEg02cOK1iYts=;
	b=GVjrUhQ5cP5f/dTqR2LpT8cJ9/ciP1TIU2bQ/lZgV6IWMeswaweFyqJZZEwbpB6a
	RIDLWF+0rd2pVV7xQvzzL8aoDBQK/CcvAvQV4zPXrwJPaqm4ftU2v2L3xwmo+UHg4NG
	xU3sMml2k9XPv0QiUJnuf08dFivpyUP7P7y+7uAE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1773270513;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=OIJ2jS4dUbUjTgFMfE6GJIzCUFUypmdEg02cOK1iYts=;
	b=j13RVIP0eWnsgpCqKswkN7uvIDic3mJ9A9/fV8dV8reHsfv0+TRkIQPYQBtLPOPo
	aFz/mSVYsX2sJry7tCbiKXDJI06R29EP3aWPmXYi8DGPaJ2/EszxJCAnTbOkmNnuFt7
	Eyas510/jM7oGDmcD/knDgcUuhQyPl76SAEXhCao=
X-Mailer: git-send-email 2.53.0
In-Reply-To:
 <CAH5fLgiQm=2YYvmG54o-MEt2m8x5V5xZrtmsqEUtuB9OZ=FPOw@mail.gmail.com>
References:
 <CAH5fLgiQm=2YYvmG54o-MEt2m8x5V5xZrtmsqEUtuB9OZ=FPOw@mail.gmail.com>
From: Jamie Lindsey <jamie@matrixforgelabs.com>
To: aliceryhl@google.com
Cc: paul@paul-moore.com, jamie@matrixforgelabs.com, jmorris@namei.org, 
	linux-security-module@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH v2 0/5] rust: lsm: introduce safe Rust abstractions for
 the LSM framework
Message-ID: <0102019cdf28b7c2-c69abd03-cd5d-4096-adce-1797b162c083-000000@eu-west-1.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Mar 2026 23:08:33 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.eu-west-1.dUvNRtpqGVRXeo8wh60CXsl7GQehaaQ6nnrtD0cVQa3Ql6wtvHFwU/L0ElxknTtyiIJqbukn1OjAm5wWeKC4/L/mSl4kXjXWbCD+H4nPl2leK4flNX+koNzOtq4VJ309U1FPreISQBpCbnqANIVuwUyneL8ocSNAtI9Qxd/4vCM=:1.eu-west-1.xc5b6Z4+0WlftYwtQHAHsTtsfYdZQImSOXWypZD9BdY=:AmazonSES
X-SES-Outgoing: 2026.03.11-54.240.3.30

On Wed, Mar 11, 2026 at 07:48:57AM +0100, Alice Ryhl wrote:
> What is the intended end-user of these abstractions?

The intended end-user is a real, policy-enforcing LSM for autonomous
agent workloads -- not the sample module included in this series.

I'm building an agent-native security module that enforces capability
manifests at the kernel level: per-agent file access policy, network
destination restrictions, process spawn depth limits, and pre-exec
threat detection. The agent identity is tracked via the LSM security
blob on struct cred, and policy decisions are made per-hook based on
compiled manifest rules.

The sample LSM in patch 4 exists as a boot-test vehicle for the
abstractions, not as the target consumer. I should have made that
clearer in the cover letter -- that's on me.

Regarding Paul's point about example LSMs: understood completely.
I'll rework the series to present the abstractions alongside the
real LSM rather than the sample. I'll review the prior work Paul
linked and the new-LSM guidance before resubmitting.

Thanks to both of you for the fast feedback.

Jamie
