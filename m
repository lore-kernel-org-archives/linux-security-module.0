From: mjg59@google.com (Matthew Garrett)
Date: Thu, 05 Apr 2018 18:03:37 +0000
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <20180405185949.309216bb@alans-desktop>
References: <4136.1522452584@warthog.procyon.org.uk>
	<CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
	<13189.1522784944@warthog.procyon.org.uk>
	<CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
	<9349.1522794769@warthog.procyon.org.uk>
	<CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
	<CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
	<CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
	<CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
	<CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
	<CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
	<CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
	<CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com>
	<CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
	<CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
	<20180405185949.309216bb@alans-desktop>
Message-ID: <CACdnJuuXexHPCkK5GW-XH2bjjXiRRg+9TFWfzeZt63-q4=Je0w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 5, 2018 at 10:59 AM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> VT-D

Once Intel provide that on all hardware and actually make it work reliably
with their graphics chipsets it's certainly a solution for the PCI DMA
problem, but right now it's still effectively undeployable for a lot of
real world cases.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
