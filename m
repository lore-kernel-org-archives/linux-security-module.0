Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4F2701AE;
	Fri, 25 Apr 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745550607; cv=none; b=K+Em7ymYSsXfZ+19iqQZNlUb2dvc6EWP9KPH2feT1j8xp6N99vhthUhxyVIlK0fZTy2KYqizghYSxE7XQ2sn4I3CveJNbI6TokNJLhecX4U7yeska3eu3Q76j+MG2ZLgIVLEpjBwtRzgfoI9Wz+PyCDFyPmBqGSEWxz6DEw3fGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745550607; c=relaxed/simple;
	bh=DYkR0BRzTZgqgT2AoNDoUCSHnqk+V3ro/oiA4Y5jtOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur4BCXer1G1/NBrZ7ffoga5AsVPdyQ/vOQm/L8dYBOggKr8BGiNtC52e8yHhh8eZkx3gisKL/fTHcrrbIiDHVBjm5rP7AvjaY0SNz7y7Z7tBcHy/UnIcP04yfMpb3Qp8iE9rXLpftUFLjtPTGU8wgvXaaOfYzak2lBwbNGYDVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=d/i6IDyu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="d/i6IDyu"
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1311754bb;
	Fri, 25 Apr 2025 11:09:52 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: zilin@seu.edu.cn
Cc: jianhao.xu@seu.edu.cn,
	jmorris@namei.org,
	john.johansen@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: Re: [RFC PATCH] security/apparmor: use kfree_sensitive() in unpack_secmark()
Date: Fri, 25 Apr 2025 03:09:51 +0000
Message-Id: <20250425030951.2504900-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418045250.1262935-1-zilin@seu.edu.cn>
References: <20250418045250.1262935-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaThhCVk5JShlOSx0YT0sZS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a966aec496d03a1kunm1311754bb
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6Tio5UTJODT82KC9WTAkh
	LClPCilVSlVKTE9OTk5LTkJITkNNVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKT0lINwY+
DKIM-Signature:a=rsa-sha256;
	b=d/i6IDyuFnDxeMHXIbkS/Q3PTEWGYg0P8V88fug1bevYfvd3JYIJMbTTxD8PTu4XSgDViuqZmikOD6ba9phnypu4HQ5syCAk18eu8qwggoALgqBXMqKnjSsWNIB1X+uN2v7ncrVEwUXA24ZI2/LbSaJFT6dyvqbvRHrgHOuB5+E=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=6BR8cXu8hwNR5rnYgCOTDWahbVAq41fdERazexhWcSQ=;
	h=date:mime-version:subject:message-id:from;

On Fri, Apr 18, 2025 at 04:52:50AM+0000, Zilin Guan wrote:
> To mitigate this, replace kfree() with kfree_sensitive() for freeing
> secmark structures and their labels, aligning with the approach used
> in free_ruleset().

To clarify, we propose using kfree_sensitive() for secmark structures and 
their labels because they are already freed with kfree_sensitive() in 
another error path, specifically in aa_free_profile() -> free_ruleset().

This change aligns both cleanup pathways, whether aborting early in 
unpack_secmark() or cleaning up later via aa_free_profile() -> 
free_ruleset(). It ensures that all secmark-related allocations are 
scrubbed before deallocation, mitigating any potential security risks.

Best Regards,
Zilin Guan
