Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E032alIf"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA889CD
	for <linux-security-module@vger.kernel.org>; Tue, 12 Dec 2023 17:44:06 -0800 (PST)
Message-ID: <b683d150-5fa0-4bec-af07-c709ee4781d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702431476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QR2VSsFCexoYoHMfOMQBYvflj8tNx0RG9xJyXqIMWgg=;
	b=E032alIfX9+oqA1vQ8NPUQP8BXQQdd4z0effO2ed7bpJU4KR6h1Dx+vF0XiNgeJUw+F0Au
	4rHGpNUz8ct/ep1PdVyRqCFl8WZ0jZHxHFhqCGit52bEPaixmZGbpz6zzQTVAaCL62FMeI
	qjw1ZHb0Vek67tpczRcmr59hXttBQvo=
Date: Tue, 12 Dec 2023 17:37:47 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: add mapper macro for bpf_cmd enum
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Christian Brauner <brauner@kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Kernel Team <kernel-team@meta.com>,
 Sargun Dhillon <sargun@sargun.me>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231207222755.3920286-1-andrii@kernel.org>
 <20231207222755.3920286-2-andrii@kernel.org>
 <CAADnVQK6WWcgKtPNQrGe9dM7x1iMOyL943PVrJjT6ueBDFRyQw@mail.gmail.com>
 <CAEf4BzYHHdQsaGBFXnY8omP4hv_tUjqxHWTNoEugi3acrE5q=A@mail.gmail.com>
 <CAADnVQLoZpugU6gexuD4ru6VCZ8iQMoLWLByjHA6hush5hUwug@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAADnVQLoZpugU6gexuD4ru6VCZ8iQMoLWLByjHA6hush5hUwug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/11/23 8:06 PM, Alexei Starovoitov wrote:
> On Mon, Dec 11, 2023 at 8:01 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>>
>>> While I can preemptively answer that in the case vmlinux BTF
>>> is not available it's fine not to parse names and rely on hex.
>>
>> It's fine, I can do optional BTF-based parsing, if that's what you prefer.
> 
> I prefer to keep uapi/bpf.h as-is and use BTF.
> But I'd like to hear what Daniel's and Martin's preferences are.

I think user will find it useful to have a more readable uapi header file. It 
would be nice to keep the current uapi/bpf.h form if there is another solution.
