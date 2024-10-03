Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5023DE;
	Thu,  3 Oct 2024 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916400; cv=none; b=bA/z7ymUg/bw+EZC8xcAuAQ2XA1XX2ae7Bb8TgKOAwgFbO+zSwyhqH6oZqIAnMEeqKi+oGPkzRBkjpU1saMx7LGRRZhHFyMlvbxyJXluefBekZ5unaGdsu5Onpc4Yo6vifSXudsDIVN4ipnkcIFkzGLfn96gTHEAykRR/8nmpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916400; c=relaxed/simple;
	bh=+6fNRHwAMI0XLMcrvjqdzO544i3KmFEbtisOAFQSioA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=enn2/Pjt3qWDW+yVK6ISWkWtEN0YJcDf4QtfY4sBML7+ClsIL9Dz6Ln7zLzn/2MBV2jhm1snk2B2tMQOvN+Mn44Ymri77lxVR7PPJB1jXz6/8Xx/9cucvAM59e6TFJFOi9uV/cjSsYBfxb3cWhJIFKwbNXqmifFmvRdnoE5fs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=ao32vf3g; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="ao32vf3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1727916285; bh=+6fNRHwAMI0XLMcrvjqdzO544i3KmFEbtisOAFQSioA=;
	h=From:To:Cc:Subject:Date:From;
	b=ao32vf3g9yaNF0J4fJKQHG0Ywk6TuQxAMvK2d4b9UxQvjOducMfVnH94YNC5fIpY6
	 zAxS6KyQqlSGcAwlHZlWqYlXgwszz8Y9p1398acx3+nywH+kYoNvu+LvbQMIpCP2mc
	 fF4wgSDDWwVNf+NrPoFbCT+wuQXqWgCgXRC+N/MJ0Wetm9vxf8Qx+LL+/w6S7E2WZa
	 exUHFkuuAtjvgckk89hyvycjI9PF9g3zFRyW+DVPBwDJKA4oSPz+g9u1nrB0UqoqFp
	 Dh5YpHBZA2QDIt6E5sHIBL5JWk4tpBH+NBaWiwoPPE9L2L3jvFulL9LC8UMoKUpC5O
	 sCxIQ35RQKrQw==
Received: from localhost.localdomain (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id CD3AD1231F1;
	Thu,  3 Oct 2024 02:44:44 +0200 (CEST)
From: Matthieu Buffet <matthieu@buffet.re>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v2 0/3] samples/landlock: Fix port parsing behaviour
Date: Thu,  3 Oct 2024 02:47:09 +0200
Message-Id: <20241003004712.255126-1-matthieu@buffet.re>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Mikhail,

Thanks for your feedback on my v1. This is the extracted fix for the
port parsing part, along with the help message clarification to make
the sandboxer sample more user-friendly. I'll apply your suggestions
on the rest and send it asap.

v2: no semantic change, just selected a subset of diffs and refactored a
str2num helper based on your patch, Mikhail.

Link: https://lore.kernel.org/lkml/20240916122230.114800-1-matthieu@buffet.re/
Signed-off-by: Matthieu Buffet <matthieu@buffet.re>


Matthieu Buffet (3):
  samples/landlock: Fix port parsing in sandboxer
  samples/landlock: Refactor --help message in function
  samples/landlock: Clarify option parsing behaviour

 samples/landlock/sandboxer.c | 128 +++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 43 deletions(-)


base-commit: af3319b445a28d51bf936cf4fe350f9c8eda5a3a
-- 
2.39.2

