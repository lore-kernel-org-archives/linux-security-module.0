From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 16 May 2017 15:03:16 -0400
Subject: [tpmdd-devel] [PATCH v4 2/2] tpm: vtpm_proxy: Implement
	request_locality function.
In-Reply-To: <1494460462-29022-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1494460462-29022-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1494460462-29022-3-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <484d5d9f-c769-3e38-4fe5-6dede79de717@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/10/2017 7:54 PM, Stefan Berger wrote:
> Implement the request_locality function. To set the locality on the
> backend we define vendor-specific TPM 1.2 and TPM 2 ordinals and send
> a command to the backend to set the locality for the next commands.

When this says "for the next commands", does that mean that the locality
is fixed for all commands until a new request_locality is sent to change it?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
