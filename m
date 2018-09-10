From: jarkko.sakkinen@intel.com (Sakkinen, Jarkko)
Date: Mon, 10 Sep 2018 17:29:52 +0000
Subject: [RFC 00/12] Multi-Key Total Memory Encryption API (MKTME)
In-Reply-To: <cover.1536356108.git.alison.schofield@intel.com>
References: <cover.1536356108.git.alison.schofield@intel.com>
Message-ID: <0952428c3fe91573e840247ca4e579e1b4ea63f3.camel@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-07 at 15:23 -0700, Alison Schofield wrote:
> Seeking comments on the APIs supporting MKTME on future Intel platforms.
> 
> MKTME (Multi-Key Total Memory Encryption) is a technology supporting
> memory encryption on upcoming Intel platforms. Whereas TME allows
> encryption of the entire system memory using a single key, MKTME
> allows mulitple encryption domains, each having their own key. While 
> the main use case for the feature is virtual machine isolation, the
> API needs the flexibility to work for a wide range of use cases.

Is it a common knowledge what TME is? I kind of dropped out of the wagon
in the 2nd sentence of this paragraph.

/Jarkko
