Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A1308F15;
	Fri, 17 Apr 2026 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416977; cv=none; b=f65rv2+OaMH434O1x41ajboC1SZvQMAZUGqCeoiQEVOmiXZ0lYB2HJo+zaDPhVVR27CUCEyw/DH2wczo0TJGyf8o/NYsa95IgNnJZI53kAynvtEeoYsGQmVxXRG9teXnedUdD81FT8KClfzRhGGPpBFM5KptjzBppIeCertzD3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416977; c=relaxed/simple;
	bh=d57fLqZWvYiM24nffxwitDs6MlUzwCZIXN5LvOzckAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g6fRQDyBvbGUb+gdaf03ETYlVI0sdkeD+8Ko5wwCHvvS+zwlGBE3ufZPRf/24A5ZAqLnYS34R2VcX8LVoYpRio7LvbKnXPtalmjcOIu+RFIqDNPGwMkFYVSe9vRqOcBdH9+dM7vBQETo2N9v0ZB0zJDnaAASNWU2xTPKXuD0x+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 63H99AJx023198;
	Fri, 17 Apr 2026 18:09:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 63H99A7s023195
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 17 Apr 2026 18:09:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c5700495-36ca-420a-a6aa-92131af50468@I-love.SAKURA.ne.jp>
Date: Fri, 17 Apr 2026 18:09:10 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: reject short exec.envp[] names before suffix
 checks
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417073249.93906-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260417073249.93906-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Virus-Status: clean

Thank you for a patch, but I don't think we need to apply this patch.

The caller is

    if (!strncmp(left_word, "exec.envp[\"", 11)) {
        (...snipped...)
        if (!tomoyo_parse_envp(left_word + 11, right_word, envp++)) goto out;
        (...snipped...)
    }

where the left-hand string is guaranteed to be safely dereferenced.

