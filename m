From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 12 Mar 2018 13:00:26 +0200
Subject: [RFC 0/5] add integrity and security to TPM2 transactions
In-Reply-To: <1520706580.4495.4.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
	<18e2f4debbbc05ed4169d3eb263479df91941aa0.camel@linux.intel.com>
	<1520706580.4495.4.camel@HansenPartnership.com>
Message-ID: <5546fb07e9f45b0d501cfe9b6ee62712153ef32f.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:29 -0800, James Bottomley wrote:
> OK, you might want to wait for v3 then.  I've got it working with
> sealed (trusted) keys, well except for a problem with the trusted keys
> API that means we can't protect the password for policy based keys.  I
> think the API is finally complete, so I'll send v3 as a PATCH not an
> RFC.
> 
> The point of the last patch is to show the test rig for this I'm
> running in a VM using an instrumented tpm2 emulator to prove we're
> getting all the correct data in and out (and that the encryption and
> hmac are working); more physical TPM testing would be useful ..

Sorry, I did not notice this email in my inbox before I responded
to you v3 cover letter :-) Thank you.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
