Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723545;
	b=slKUZDIyTyS846T4qW1ubsVS7ilDh4NaNvvUCxiapecdraQXWiw8sFPlRHXdyjzfvZue
	 VQmtrlemcuKlM8tTYV7T/eGCHpBGaVeGZSmo4iPj4ropnHpnCqQtzU1wZKmkNkBAT0WPU
	 GPyQ/hfczX38V9wWK5VVvaTkfEquzRvwe8ZOHO/zlBTWsQxco+yXMRk6wiirOfXOhhac+
	 0mXBof+6W577GPEiI4/tRz0KKlfqWxz7kEd+mtrHy4DFMqKEfSaUoHJzrMYztZgwycjur
	 2xeDEaBD1irBZ8vwMGNqiRjxbuqmaG2Cz7rAR0YameKG+icawyqOyxSesr82xyvKWHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723545;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d8l62yefWpLh5/qnJKW3hO6NkJRtByoGvqbuty2HIFQ=;
	b=sp9epT6vuLeWwI64mgWjioNQUguT19nhu4JuDbUv+ig0tfF8bhiyRWHIKcxa3SHitZO+
	 b5DrkYxKAbzc0YeeQyNLDXvU0TfK+yEuVve8X6CoGXi4xXet7F2rMQIO9ZLQa2dtHPV+x
	 iZyZfJg+WqTkZA/oQBpxJ5e5MCMUzMxW9UIvAKYQGsESzHTDCwezVGPJW1s4S6XmEQ6HO
	 XxEuupJa0gkXy83jXgTksiKEsk8h5h2CBM00FBMkZGGcw+RH3lQFZe58/8Hs4bY8JdTJq
	 aDuNqlyB2GLhh1772/8XSWsA9d2Qjdmt9l637DWHvnOoPKFu3DO1zEf/hzLk5iN5jvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d5aQTIH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABE606A321
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5aQTIH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC01F000C4
	for <linux-security-module@vger.kernel.org>; Thu, 26 Nov 2026 20:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723543;
	bh=d8l62yefWpLh5/qnJKW3hO6NkJRtByoGvqbuty2HIFQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d5aQTIH/G0JMBVaRM9e1XGNOyLwvxFf2pdhTk0KxhdoEH3nTQthMr4jpTedTW+idq
	 hbZ9WtRecZkt8utG3GrIJFMn7m+y852c5YZJTf+nKsR+y9IhRk1uXGlOmW8mZCx9Eo
	 95SN4MCfdy9N9/5tSL8BQTQY9VSWml7u6Y9uytSzmtGsoq/2JWEaEWl1JiyZE7Gu0u
	 xOJZ3Uu/eNJ/L97g0ePTxLrejQe6T0CCe0M49kIoRgBFYzOOwie77k2RhIh5bzZBt7
	 9Rp4ywRsbGJ2RvmXiaYJYzZnD57jBLcwU2y9JoNZd+/L8W83xCZYM4lZ8HcPAEFtJX
	 USr4oqBMptUMA==
Message-ID: <sashiko-outbox-236147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KEYS: encrypted: Wait for RCU callbacks before
 module unload
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261126200103.2806716-1-zhenwenliang@google.com>
References: <20261126200103.2806716-1-zhenwenliang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 20:05:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126200103.2806=
716-1-zhenwenliang@google.com
