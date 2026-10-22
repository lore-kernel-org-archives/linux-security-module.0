Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663179;
	b=1mq1h7utVRpJdS9krjiOgLHuoNUPtSV7nYlLJVLLHS29qhDH8Qqx3lLb24dyLEew4gA+
	 Mcw5bRfKTWDg/dHdjzPY3Akn/eeE3tQ+CkvLIA+YZynXFA1hacDMZpx6OsoJgUTgEhy8D
	 LarzhfmlXeex1YZOYd8FhiSWHj+u5+k0pxKRVb0N8Ti7AC6vTY7B1SDLkAJir8CSKj+tH
	 AsIdH+T05QDNVThYBqaW0IRq343g57oeX6rNs6r7uWtcz8YLVcEIPnxtCq0LKoCTcHCq2
	 bv/wd5cV0ZQfcOpP0PhOGbsdBoKSZM+zEvhmDPXL5Ew+xA22Ln8siYEoCgkjav4g2NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663179;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IoH7ekxN//XilbjyHr/WJ7HKfImuR7n5++a/wt+yFvc=;
	b=dR4jk2bZJqy4pdODJwDlHU9OynIx5jpaS2lQ/h5kUGq6Ij2ZA9DLtmSx91rUp5odk793
	 lXEImK16XuEPmD0WH9IWCPQod7SpkkTzhcrMCImy3al/Q1h4g/C9/cd7Bc8kP8Z7tpoLl
	 PAELHod1HZbYon7wdbAVp0pCIJf5WA4VRdiWOcLfp5appQBG2ghN/1oQpd1P4swrbsDY9
	 bsqC6axBsdlJTBDXLCUPHccR0IzmBan95Lg3r7fOd6SyT6pONCPSW8vORXLKaQLLtmRZz
	 fLL1cJrc4advrAI2vUnEMPY47rwQuJRyNeTi5Kc3qmA67eps9e/umcyjgRcdpNZv8rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtbhcMcf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854DE606A31A;
	Thu, 22 Oct 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtbhcMcf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69681F000C8;
	Thu, 22 Oct 2026 09:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663178;
	bh=IoH7ekxN//XilbjyHr/WJ7HKfImuR7n5++a/wt+yFvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtbhcMcf1IpwvLJwfCFCO2HbnnTWGh+2wjxLooRbBwVXv6jZq1Dq9RrWOXuZlIcIM
	 0LjgiRYGO6PyvlsRCAtx6KbdXCx3zJHLHbZWsna5F5Qlu7BHz5EYT/HnkoiHwhXckG
	 ppXGvymm1kR7ds29QEyI4saH1fOOf8oGEYY44SEqiyH7iTJtVtouLT0dHKI3WPG4//
	 eT1jDI3z9J77BNGfxUMRnm2t9IaEu7yvoaWoauZ24H1JbhgfTLTPq989SFFb0ZIxjZ
	 k1dbIsP0spq+nfDB1TNkmEUIFTbwJk1PKPjfX62FlFRVAQagxtSglL6ZuNVbMcA4qg
	 ltQ+F82tjDzBw==
Date: Thu, 22 Oct 2026 11:59:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, catalin.marinas@arm.com, 
	will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, robh@kernel.org, saravanak@kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, zohar@linux.ibm.com, noodles@fb.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Message-ID: <20261022-whispering-cerise-malamute-94d7db@quoll>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
 <ath534EEbFntir8j@earth.li>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ath534EEbFntir8j@earth.li>

On Wed, Oct 21, 2026 at 09:37:51AM +0100, Jonathan McDowell wrote:
> On Tue, Oct 20, 2026 at 10:37:27AM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> > implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> > buffer location through setup_data, not through the device tree, so the
> > buffer is never found and the IMA measurement list is not carried over
> > across kexec.
> > 
> > Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> > and select it for the architectures that pass the IMA buffer location
> > through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> > powerpc and riscv). Build the device tree implementation of
> > ima_get/free_kexec_buffer() only if the new option is enabled.
> > 
> > Select the new option also on LoongArch, to preserve the current behavior
> > and avoid a link failure. LoongArch does not pass the buffer location to
> > the next kernel yet; this will be addressed separately.
> > 
> > Finally, don't select it for x86, and use x86's own setup_data-based
> > implementation regardless of CONFIG_OF_FLATTREE.
> > 
> > Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Reviewed-By: Jonathan McDowell <noodles@meta.com>

Please use kernel style tags, so Reviewed-by.

Best regards,
Krzysztof

