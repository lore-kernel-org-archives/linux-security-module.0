From: marcel@holtmann.org (Marcel Holtmann)
Date: Thu, 20 Sep 2018 09:26:18 +0200
Subject: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
In-Reply-To: <20622.1537291117@warthog.procyon.org.uk>
References: <c33c759d-9243-8885-7c5f-667681b759c2@gmail.com>
	<14f91823-474e-1b46-d305-12229dac8967@gmail.com>
	<0d51fca9a29458a40121df0c5380af91e3429c08.camel@infradead.org>
	<fdee179b-cfdf-7a2b-3193-e114f0084ecb@gmail.com>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<1537253993.20009.62.camel@infradead.org>
	<14067.1537285833@warthog.procyon.org.uk>
	<745318a0-51bd-be8f-2251-44701ad75830@gmail.com>
	<19247.1537288419@warthog.procyon.org.uk>
	<23698.1537289705@warthog.procyon.org.uk>
	<20622.1537291117@warthog.procyon.org.uk>
Message-ID: <58F37819-78E2-45C8-8F04-4F21DDFB640E@holtmann.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

>>> Yes.  It shouldn't be much code, either.  You still have to check for X.509
>>> DER since the kernel currently supports that.
>> 
>> For reasons of backward compatibility, correct?  The kernel also has
>> mscode.asn1 which we would need to support as well.  Since we can't break
>> compatibility then perhaps this doesn't buy us a whole lot in the end.
> 
> Don't worry about mscode - that's not an asymmetric key parser.  That's only
> ever used directly from verify_pefile_signature().
> 
> Currently, we have to retain support for DER-encoded X.509.
> 
> But there's no reason we can't have a PEM parser that decodes the PEM and
> selects X.509, PKCS#8 or TPM based on the ascii header in that.  PKCS#8 and
> TPM don't need to take DER directly.

since we have to support DER-encoded anyway, can we get the current patches merged (with fixes to the commit messages for the openssl examples if needed) and then work on PEM support inside the kernel. For me these seems to be two independent features. And in the current form the patches have been tested and used.

Or let me ask this differently, are there any objections to merging these patches with just DER support?

For example in ELL we have implemented the PEM to DER conversion before calling keyctl. This can be surely added to keyutils (if calling openssl is too much to ask) or even the kernel itself. However this doesn?t change the actual functionality of handling asymmetric key operations. And I would rather see that merged and established instead of worrying to much about the multitudes of possible encoding forms of keys.

Regards

Marcel
