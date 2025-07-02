Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E898BA2E
	for <linux-security-module@vger.kernel.org>; Wed,  2 Jul 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751427432; cv=none; b=HQjZMz+es7zNxK232Qtp6JTOTLJIXULl6HXpbly/ywKnaYBlmAfaDvJhAwqnlY0u9uWH0hcswULg4Y8q/OT8PX7fo5vL/HrCWeBHEn3zfyfvvR1EnIObqgdx/jXLYwi7fhs7ocxWDC8pIwADk3k3LH1tHHZ/a/8fYxDp4wqf/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751427432; c=relaxed/simple;
	bh=XaiwbIMPsMaaSTlk+gSCtVQ6m1L4r9aIOjqGsZ2eEE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfR8o8iDMjsCDOrl7kU3l+0NqBa6r2DLmfey5rresYyLOwDCFmec3mnCKK2n8whT0d99vcHsdbmGExFN1XKDdgN/Kj1n0MVh3E0KJAvaTdOP038Bmt+55yqLs6iliy1+g/yo/9LxTDmZ+hK4ga8Pc2nXft6gMu7vDagozInHuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NDDFVp8w; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NDDFVp8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1751427428; bh=XcmfsYelPSB4afUXVGT6hO90E+RTNxeQBu2TFm2PX2o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NDDFVp8w/g+1zhKqLa1WisvaUTmU02XRikKt6N2TefUtB+bPUsMenLNUgzQ3e4Ns4SOeFeDmGg1CAMx1hrwg5STzvLcQew0EnN4PO82p6n7nJMjJpXnscD0YaBYCVweC3jSLUCyOcWAA4pHKcVPiaF0BzL6cztbKgKMeQRafY30k3yACrz0X04WzWP/rrI0gRCnaAd7CIHxzy8nJzdmaurUrCpQA+zp8A+dtvvw9RgfeDAbdIKckRX2doTwiCq72/ltvKMCqoNmtObK4CvXMYM52qj+i1Qf46vnoKvAuUzKZYgoRb+rCTTD0SVJ7+mFbF9pA21xBQPro7bV/UMgaag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1751427428; bh=0+tXuY0qblZ1wgadSVCJv33bxmkR8t7zQpVzWk5DhF+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nzdWUp/Fiv5taEuzH7R21e9VPTFuQM34//+Z0NgC6qRjDWO3AINiSV3KOXpkla/yhApHdxEkgyBIp7cgLmjxDGqeUulXmUG1dnCtIy59pFVvnpt/MCGWgfRAsqYLeAEzncBYWQhP+3TvxETMtXs/jfENLfar3g0q/5SP//lk2RPPSrw+VyvdBBMvqAh+jEaomgbsWhZbAoYw3J6CIv4Oi7rZzsvx1ybHcgmtoOgGFtJl3PRcpY5v71+1WuCLhtvccbC97hxisP7ubSP1ZRHNxth5S/RavtLtYPRtPgZkcSiPNaopnnBLoD1hjRHD+bBLeE0qpxvJ5A/QEKjX4SJDqA==
X-YMail-OSG: VTcAmY4VM1nF.BmJjltRDybV6eIpWhFvEu0xDTRd67Tr95v2zu5cCYe8cOXvxnG
 8ii_xrzMBoX_71b1b7cSLRf3Wdff0gFC6LsLCaohSeqTzD97r5BFTDZgRvZV6aLf3jgVQwrZhBNW
 pI9kjQ95py6AfOw2HpYTYNNZwapfaPwLEvoPYVL_g7iNdxTs7ztfZzU4SdbmQN6xJVnUmvMUuFtX
 2UZscdSp2z8njIE.tkzFzcNiWk17JDCp.uKI19A7XxN7gbWbkiHNYh7PaSeoKTH7iXYadD9SjSIz
 fzMcSfwh8GCTo6jm9zBWCJpvSkqlTxcuKHqzpITdjnYkfwoG5BNE9fu_ZAAKCqdwvFolGqE4f85N
 MZAPEXiatcCRFFqtIKRJ5vjLhdsUIfa3oZnftt4wQLH1eQ4_zMqShcaGeklQPj7l_u0WjKFr3Dmv
 WcCPCejqnRYS5BZeGpSvrAZ5XpC5MhaXxa7jPvZ0xqsBl08U0FsUNNV0ZvRO3uQGEKagaPCWdX0G
 YcBGuQl.Hl6GsRKSnBNwqr0sVOCoXsdsJWeoBPPIMlFahdqR4Uhhu7hThexzww3u2cpKo__flVfg
 au4IstAz5s6Cbda7iB0wiCA07B9O40H0SDQX62EraBpVM7XSnNgj6nR4pATWC0_3BFvR9Tp_omUg
 mhslmfDWWS7kpTRInkWOAnPc7ISt7e74arX6MXQhjpgdI.dBLfTmjcFDmDxaYHKwX5lrFWzhM3I7
 8YR0P5YrFuGf6HhPYt2uSn.ZKpzZNihwBUbs5Rv3rDT4HgDx2CkQ6uX895hz2q7xa_d4GI5oTRY2
 tSDNV3v_Qi29KFNRRrLa_Se9ZDbRLXDOZUxvLM9xzDmlw1_IOXqQ9Sc3edL5UDd5970fr2guhCrd
 9TMcXm4tc7xU9y4esJ5BVho8n2O1LSG5mfCBr8_LIiAQZqzwBdC3moGoW2PTmYs3hz98hOd98mWC
 k2R27JjHLMvE3eCcc0IARgNMQB5mSJvk_LznKe6uNIIfqLQJsl_U.jUGPxZztjIRR7xS4SS5T3lS
 Dd007bLBOi5ZEiNfDeJ6sLh32aa5oHmL5HtULeGgr0L4CsdnqNJx_4_I6PQ1dIIOAcb0AH5i0.Kx
 gI59ot.gy1CXd1bDwocUC3UAb4F5Io4BYeftY1LgaTfvDSykfhZEws4XbAirnn2doZgBGMLWX2TV
 r3Qacjx8bRC_gIfkmYmA8p0Zlebl6FoMl.mHh4V65Hs8UdE3zHM_bDQ2akIuDTncQ95pMCVnmP9O
 _4AS_4vSKSX8nYzxY83N_zO.ltRVn3PdCxKO.FnbtXJyL21BlvrWFMTfjJq8VFv4bo7IDXDESdRe
 zIDxrr8020jnuo_jgnNUqzA_zhpClkjOcMfvgG3UdSNhym.GBbTl1kcIYq7odiBNE4I7l0.FoIbU
 ImWLCVfoNjNcQ3u9wkXECnQ__6Q.5C.pnEiy9hjwEOBFmaqF.6LxKthuxKcwgZkrB8QfUD6DPWSZ
 DgusJKzcSFPznZ86F2.tM6fYFtZri.3EJB4y2EJEhYilzPLpdyL364kNJ.GnXs2oU8u4oFvFqv8U
 p2AU3mHBPE2sSLTQ8E1wAGnsVf_wWlEZVaf20G9FO_PdhmVdwdLofVcdIAvRRhFojsFMHk7AQ9S6
 wirFqHh5qTbsBUmMimL4VCJ9GnOts_gpTgmVKnR80Y_WXK_ZyzXYYIKBEZKaKYu3R91OOEuQWNXE
 Rh6G4arGOUjUOBtqbnRXskpP3mbltxASrU3gO21pB9wbK4DJMpUq02OEBffUke5oXJkIz1m_.XYx
 qnjjPj0MK5oOVjrG.DiXu1JmPLFjy3LssJQmTSnYafKaI5EpL63iedfh.OH8GdKSE.nYEX9VRufO
 9uLLAmKCTkmtr2y6QD0XoW8BeUCiN5tVD6_XOXvM4AE591I9wvvIdWRCbI98WHbhusjN04iZKXXw
 IPecJkHLKOvd9z9tu_KdgZY96sor2.05WrzUSEVdqunkJ0EEhTGbO_UfXFLHV7S.Ikg6WFetamck
 fsdwJMThEITPG34BKJpd.I8jRvocyo36bQANPr2NLE0eolVCmQSsutNUSm7CFZaISufqi8go_fhK
 Ajr5odaTDcaz62Eg0Vwsetu804sJ.0Qozk7nmdPZBIqJdx0bnlS4vvSMmzzPGd43vjafbPiNRowQ
 yWuyK.4k3RE7J5Z8mNACuZnv3wp_WRTx3T_JzuE21bGc2sCPvZGWubQEFMYL8Alj4xO4q7uu6Mrh
 6TXvbYSDLPwPyN_hVy21JHWpQr1Seq71jvPOb.eQIHtA50cQcMBSP1cGbYmPRVzbyQ_0jB_Wl5ar
 ywwG.6R4u
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9f859c66-5fdc-4eb9-9850-71753ac0d9b5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Jul 2025 03:37:08 +0000
Received: by hermes--production-gq1-74d64bb7d7-fddgg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b52f0860c6f7441b784c77ecb7beab32;
          Wed, 02 Jul 2025 02:46:33 +0000 (UTC)
Message-ID: <4ad9a4c1-658f-4c58-bfa9-473ba26c656f@schaufler-ca.com>
Date: Tue, 1 Jul 2025 19:46:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: fix kernel-doc warnings for
 smk_import_valid_label()
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250626164741.1028245-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250626164741.1028245-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24076 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/26/2025 9:47 AM, Konstantin Andreev wrote:
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506251712.x5SJiNlh-lkp@intel.com/
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>

Added to smack-next

> ---
>  security/smack/smack_access.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index a289cb6672bd..09167be79122 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -642,9 +642,11 @@ struct smack_known *smk_import_entry(const char *string, int len)
>  
>  /**
>   * smk_import_valid_label - import a label, return the list entry
> - * @label a text string that is a valid Smack label, not null-terminated
> + * @label: a text string that is a valid Smack label, not null-terminated
> + * @label_len: the length of the text string in the @label
> + * @gfp: the GFP mask used for allocating memory for the @label text string copy
>   *
> - * Returns: see description of smk_import_entry()
> + * Return: see description of smk_import_entry()
>   */
>  struct smack_known *
>  smk_import_valid_label(const char *label, int label_len, gfp_t gfp)
